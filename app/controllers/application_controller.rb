class ApplicationController < ActionController::Base
  # Prevent XSS: http://stackoverflow.com/questions/13858932/protect-from-forgery-in-application-controller-in-rails-3-2-9
  protect_from_forgery

  # Check every request for authorization
  check_authorization :unless => :devise_controller?

  # Redirect to root on authorization fail
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  # Add parameters to accept invitation
  # https://github.com/scambra/devise_invitable#strong-parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name, :email, :remember_me, :time_zone, :reminder_threshold, :notifications])
  end

end
