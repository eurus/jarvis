class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  # GET /plans
  # GET /plans.json
  def index
    user_ids = (User.dfs current_user).map(&:id)
    @plans = Plan.where(user_id: user_ids).includes(:user).includes(:creator).page params[:page]
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
  end

  # GET /plans/new
  def new
    @plan = Plan.new
    set_local
  end

  # GET /plans/1/edit
  def edit
    set_local
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(plan_params)
    @plan.creator_id = current_user.id
    unless plan_params[:user_id]
      @plan.user_id = current_user.id
    end

    respond_to do |format|
      if @plan.save
        format.html { redirect_to plans_url, notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new , locals: {col: set_local }}
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit ,  locals: {col: set_local }}
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_status
    # checkbox == 1 done
    # checkbox == 0 new
    ap @plan = Plan.find(params[:id])
    unless @plan.done
      @plan.done = true
      @plan.done_at = Date.current
      if @plan.done_at <= @plan.end_at
        @plan.status = '准时'
      else
        @plan.status = '超期'
      end
    else
      # set plan status to wft on purpose so the plan
      # won't be able to save
      @plan.status = "wtf"
    end

    if @plan.save
      render action: 'update_status',
      locals: {code: :ok, statusClass: @plan.status_class, status:@plan.status, id: @plan.id}
    else
      render action: 'update_status',
      locals: {code: :sorry,status:@plan.status, id: @plan.id}
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_plan
    @plan = Plan.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def plan_params
    params.require(:plan).permit(:title, :description, :user_id, :status, :cut, :start_at, :end_at)
  end

  def set_local
    if (User.dfs current_user)
      available_collection = (User.dfs current_user).flatten.map { |e| e.id }
      @col = User.where(id: available_collection)
    else
      @col  = []
    end
  end
end
