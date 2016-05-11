class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]

  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @feedback = Feedback.new

    @feedbacks = current_user.feedbacks.page params[:page]
  end

  # GET /feedbacks/new
  def new
    @feedback = Feedback.new
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.user_id = current_user.id
    respond_to do |format|
      if @feedback.save
        format.html { redirect_to feedbacks_path, notice: 'Feedback was successfully created.' }
      else
        format.html { redirect_to feedbacks_path, notice: 'Feedback was not successfully created.' }
      end
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    @feedback.destroy
    respond_to do |format|
      format.html { redirect_to feedbacks_url, notice: 'Feedback was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def feedback_params
    params.require(:feedback).permit(:user_id, :content)
  end
end
