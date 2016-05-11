class JarviscoreController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!
  layout 'application'

  def bughunter
    BugHunter.create(project_name: params[:project_name], trace: params[:trace]) 
    render nothing: true
  end

end
