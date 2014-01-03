class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access Denied!!"
    redirect_to root_url
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:current_password,:email, :password, :password_confirmation,:first_name, :last_name, :phone_number, :mobile_number, :address_line1, :address_line2, :city, :state, :country) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:current_password,:email, :password, :password_confirmation,:first_name, :last_name, :phone_number, :mobile_number, :address_line1, :address_line2, :city, :state, :country) }
  end
end
