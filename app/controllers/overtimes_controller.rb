class OvertimesController < ApplicationController
  before_action :set_overtime, only: [:show, :edit, :update, :destroy]

  # GET /overtimes
  # GET /overtimes.json
  def index
    @overtimes = current_user.overtimes.includes(:project).page params[:page]
  end

  # GET /overtimes/new
  def new
    @overtime = Overtime.new
    @projects = (current_user.projects + current_user.owned_projects).uniq
  end

  # GET /overtimes/1/edit
  def edit
    @projects = (current_user.projects + current_user.owned_projects).uniq
  end

  # POST /overtimes
  # POST /overtimes.json
  def create
    @overtime = Overtime.new(overtime_params)
    @overtime.user_id = current_user.id
    respond_to do |format|
      if @overtime.save
        NotifyMailer.overtime_created(current_user, @overtime).deliver_later
        format.html { redirect_to overtimes_url, notice: 'Overtime was successfully created.' }


      else
        format.html { render :new }
        format.json { render json: @overtime.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /overtimes/1
  # PATCH/PUT /overtimes/1.json
  def update
    respond_to do |format|
      if @overtime.update(overtime_params)
        format.html { redirect_to overtimes_url, notice: 'Overtime was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @overtime.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /overtimes/1
  # DELETE /overtimes/1.json
  def destroy
    @overtime.destroy
    respond_to do |format|
      format.html { redirect_to overtimes_url, notice: 'Overtime was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_overtime
    @overtime = Overtime.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def overtime_params
    params.require(:overtime).permit(:start_at, :duration, :content, :user_id, :approve, :issue, :project_id)
  end
end
