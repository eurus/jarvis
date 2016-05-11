class SuperviseController < ApplicationController
  before_action :set_user, only: [:edit_user, :update_user, :destroy_user]
  before_action :set_project, only: [:edit_project, :update_project, :destroy_project, :done_project, :show_project, :create_project_log]
  before_action :set_buddies, only: [:users,:groups, :overtimes,:errands,:vacations,:projects]

  def index
    authorize! :supervise, current_user
  end

  def bughunter
    @bugs = BugHunter.all.order(created_at: :desc).page params[:page]
  end

  def bughunter_show
    @bug = BugHunter.find params[:id]
  end

  def users
    @users = User.dfs(current_user)
    @start_date = Lunar.last_spring_festival
    @end_date = Lunar.next_spring_festival
    authorize! :users, current_user
  end

  def groups
    @groups = Group.all.page params[:page]
    authorize! :groups, current_user
  end

  def overtimes
    @overtimes = Overtime.includes(:user).includes(:project).all
    authorize! :overtimes, current_user
  end

  def errands
    @errands = Errand.includes(:user).includes(:project).all
    authorize! :errands, current_user
  end

  def vacations
    @vacations = Vacation.includes(:user).all
    authorize! :vacations, current_user
  end

  # projects

  def projects
    # @projects = Project.all
    uids = (User.dfs current_user).map{|u| u.id}
    @projects = Project.includes(:owner).includes(:users).includes(:errands).where(owner_id: uids)
    authorize! :projects, current_user
  end

  def new_project
    @project = Project.new
    set_local
  end

  def edit_project
    set_local
  end

  def show_project

  end

  def create_project
    @project = Project.new(project_params)
    uids = params[:buddies].map { |e| e.to_i }
    @project.users << User.find(uids)

    respond_to do |format|
      if @project.save
        format.html { redirect_to supervise_projects_url, notice: 'Project was successfully created.' }
      else
        format.html { render :new_project,locals: {col: set_local } }
      end
    end
  end

  def update_project
    uids = params[:buddies].map { |e| e.to_i }
    @project.users.delete_all
    @project.users << User.find(uids)
    @project.current_user = current_user # temporary field
    @project.save

    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to action: :show_project, notice: 'Project was successfully updated.' }
      else
        format.html { render :edit_project , locals: {col: set_local }}
      end
    end
  end

  def destroy_project
    @project.destroy
    respond_to do |format|
      format.html { redirect_to supervise_projects_url, notice: 'Project was successfully destroyed.' }
    end
  end

  def done_project
    @project.status = '结束'
    @project.done_at = Date.current
    @project.save

    respond_to do |format|
      format.html { redirect_to supervise_projects_url, notice: 'Project successfully finished!' }
    end

  end

  # project logs
  def show_project
    @project_logs = @project.project_logs.includes(:user)
    @project_log = ProjectLog.new
    authorize! :projects, current_user
  end

  def create_project_log
    @project_log = ProjectLog.new(project_log_params)
    @project_log.project = @project
    @project_log.user = current_user
    @project_log.save
    redirect_to action: :show_project
  end

  def destroy_project_log
    @project_log = ProjectLog.includes(:project).find(params[:id])
    @pid = @project_log.project.id
    @project_log.destroy!
    redirect_to action: :show_project, id:@pid
  end

  # user operation without users_controller
  def new_user
    @user = User.new
  end

  def edit_user
  end

  def create_user
    @user = User.new(user_params)
    # set default password to 12345678
    @user.email = "#{user_params[:username]}@eurus.cn"
    @user.username = user_params[:username]
    @user.nickname = user_params[:username].capitalize
    @user.password = '12345678'
    default_user_avatar @user
    respond_to do |format|
      if @user.save
        format.html { redirect_to supervise_users_path, notice: 'User was successfully created.' }
      else
        format.html { render :new_user }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to supervise_users_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to supervise_users_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def user_group_new
    @available_buddies = current_user.available_buddies
  end

  def user_group_edit
    @supervisor = User.find(params[:id])

    @buddies = User.dfs(@supervisor) - [@supervisor]
    @available_buddies = current_user.available_buddies + @buddies
  end

  def user_group_update
    @supervisor = User.find(params[:sp][:id])
    @supervisor.save

    selected_buddies = params[:buddies].delete_if{|e|e==""}.map { |e| e.to_i }
    origin_buddies = (@supervisor.buddies).map { |e| e.id }

    removed_buddies = origin_buddies - selected_buddies
    added_buddies = selected_buddies - origin_buddies

    orphan_buddies = removed_buddies.map{|ruid|
      ru = User.find ruid
      User.dfs ru
      ru.role = 'staff' unless ru.role == 'intern'
      ru.supervisor_id = current_user.id
      ru.save
      ap ru
    }.flatten - removed_buddies

    change_buddies = added_buddies+orphan_buddies

    change_buddies.delete_if{|id| id.nil?}.each do |uid|
      u = User.find uid
      u.role = 'staff' unless u.role == 'intern'
      u.supervisor_id = @supervisor.id
      u.save
    end

    respond_to do |format|
      format.html { redirect_to supervise_groups_path, notice: 'Leader was successfully selected.' }
    end
  end

  def user_group_create
    # find this supervisor and set its supervisor_id
    # to current_user.id

    @supervisor = User.find(supervisor_params[:supervisor_id])
    @supervisor.supervisor_id = current_user.id
    @supervisor.role = User::USERROLE[User::USERROLE.index(current_user.role) + 1]
    @supervisor.save
    # find each buddy and set thier supervisor id to
    # params supervisor_id
    params[:buddies]
    .delete_if {|e| e == "" or e == "#{supervisor_params[:supervisor_id]}"}
    .map do |u|
      u = User.find(u.to_i)
      u.supervisor_id = supervisor_params[:supervisor_id]
      ap u.save
    end
    respond_to do |format|
      format.html { redirect_to supervise_groups_path, notice: 'Leader was successfully selected.' }
    end

  end

  def user_group_cancel
    @user = User.find(params[:id])

    (User.dfs @user).try :each do |u|
      u.role = 'staff' unless u.role == 'intern'
      u.supervisor_id = current_user.id
      u.save
    end
    respond_to do |format|
      format.html { redirect_to supervise_groups_path, notice: 'Leader was successfully unselected.' }
    end
  end

  def check_record_by_type
    authorize! :check, current_user
    obj = klassify(params[:cut],params[:id])
    respond_to do |format|
      if obj
        obj.approve = true
        obj.approve_time = Date.current
        obj.approve_by_username = current_user.username
        obj.save
        NotifyMailer.vacation_approved(obj).deliver_later
        format.js{
          render 'check_record_by_type',
          locals:{cut: params[:cut],id: obj.id,approve_time: obj.approve_time.strftime("%Y-%m-%d"), status_explain:obj.status_explain}
        }
      else
        case params[:cut]
        when "overtime"
          format.html { redirect_to supervise_overtimes_path, notice: 'Record was not successfully checked.' }
        when "errand"
          format.html { redirect_to supervise_errands_path, notice: 'Record was not successfully checked.' }
        else
          format.html { redirect_to supervise_vacations_path, notice: 'Record was not successfully checked.' }
        end
      end
    end
  end

  def issue_record_by_type
    authorize! :issue, current_user
    obj = klassify(params[:cut],params[:id])
    respond_to do |format|
      if obj
        obj.issue = true
        obj.approve = true
        obj.issue_time = Date.current
        obj.approve_time ||= Date.current
        obj.approve_by_username ||=current_user.username
        obj.issue_by_username = current_user.username
        obj.save
        format.js{
          render 'issue_record_by_type',
          locals:{cut: params[:cut],id: obj.id,issue_time: obj.issue_time.strftime("%Y-%m-%d"), status_explain: obj.status_explain}
        }
      else
        case params[:cut]
        when "overtime"
          format.html { redirect_to supervise_overtimes_path, notice: 'Record was not successfully checked.' }
        when "errand"
          format.html { redirect_to supervise_errands_path, notice: 'Record was not successfully checked.' }
        else
          format.html { redirect_to supervise_vacations_path, notice: 'Record was not successfully checked.' }
        end
      end
    end
  end

  private

  def default_user_avatar(u)
    image_arr = ["user1.jpg","user2.jpg","user3.jpg","user4.jpg","user5.jpg"]
    File.open(Rails.root.join("app/assets/images/user/#{image_arr[rand image_arr.length]}")) do |f|
      u.avatar = f
      u.save
    end
    return u
  end

  def klassify(str, id)
    if ["errand","overtime","vacation"].include? str
      klass = str[0].capitalize+str[1..-1]
      return klass.constantize.find(id)
    else
      return nil
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_buddies
    @buddies = current_user.buddies
  end
  def user_params
    params.require(:user).permit(
      :username,:user_number,:role,:birthday,
      :nickname,:realname,:gender,:rank,
    :join_at,:leave_at, :email,:supervisor_id)
  end

  def supervisor_params
    params.require(:supervisor).permit(:supervisor_id,buddies: [])
  end

  def project_log_params
    params.require(:project_log).permit(:category, :date, :project_id, :content)
  end

  def set_project
    @project = Project.includes(:owner).includes(:users).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name, :content, :owner_id, :status)
  end

  def set_local
    @col = User.dfs current_user
  end

end
