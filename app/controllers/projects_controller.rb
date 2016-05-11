class ProjectsController < ApplicationController
  before_action :set_project, only: [:done, :show, :create_log]

  # GET /projects
  # GET /projects.json
  def index
    @projects = (Project.includes(:users).includes(:owner).includes(:errands).where(owner: current_user.id) + current_user.projects.includes(:owner).includes(:users).includes(:errands)).uniq
  end

  def show
    @project_logs = @project.project_logs.includes(:user)
    @project_log = ProjectLog.new
  end

  def create_log
    @project_log = ProjectLog.new(project_log_params)
    @project_log.project = @project
    @project_log.user = current_user
    @project_log.save
    redirect_to action: :show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  def project_log_params
    params.require(:project_log).permit(:category, :date, :project_id, :content)
  end
end
