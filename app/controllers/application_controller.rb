class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit::Authorization

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:email)
    end
  end

  rescue_from Pundit::NotAuthorizedError do |exception|
    flash[:danger] = "You are not an administrator or you do not have access there :D"
    redirect_to root_path
  end
end
