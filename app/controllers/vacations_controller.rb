class VacationsController < ApplicationController
  before_action :set_vacation, only: [:show, :edit, :update, :destroy]

  # GET /vacations
  # GET /vacations.json
  def index
    @vacations = current_user.vacations.page params[:page]
  end

  # GET /vacations/new
  def new
    @vacation = Vacation.new
  end

  # GET /vacations/1/edit
  def edit
  end

  # POST /vacations
  # POST /vacations.json
  def create
    @vacation = Vacation.new(vacation_params)
    @vacation.user_id = current_user.id
    respond_to do |format|
      if @vacation.save

        NotifyMailer.vacation_created(current_user, @vacation).deliver_later

        format.html { redirect_to vacations_url, notice: 'Vacation was successfully created.' }

      else
        format.html { render :new }
        format.json { render json: @vacation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vacations/1
  # PATCH/PUT /vacations/1.json
  def update
    respond_to do |format|
      if @vacation.update(vacation_params)
        format.html { redirect_to vacations_url, notice: 'Vacation was successfully updated.' }

      else
        format.html { render :edit }
        format.json { render json: @vacation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vacations/1
  # DELETE /vacations/1.json
  def destroy
    @vacation.destroy
    respond_to do |format|
      format.html { redirect_to vacations_url, notice: 'Vacation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def approve

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_vacation
    @vacation = Vacation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def vacation_params
    params.require(:vacation).permit(:start_at, :duration, :cut, :content)
  end
end
