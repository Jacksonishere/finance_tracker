class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  #to add additional fields to the user pages provided by devise, ex: first and last name for user signup/edit page.
  #if we hit one of devise's controller, call this action
  before_action :configure_permitted_parameters, if: :devise_controller?



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end
