class Users::SessionsController < Devise::SessionsController
  # before_filter :configure_sign_in_params, only: [:create]
  # include SimpleCaptcha::ControllerHelpers
  # skip_before_filter :require_no_authentication, :only => [:new]
  prepend_before_filter :valify_captcha!, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
  def valify_captcha!
    if !verify_rucaptcha?
      redirect_to new_user_session_path and return
    end
    true
  end

end
