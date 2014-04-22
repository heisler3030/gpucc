class ApplicationController < ActionController::Base
  # Prevent XSS: http://stackoverflow.com/questions/13858932/protect-from-forgery-in-application-controller-in-rails-3-2-9
  protect_from_forgery

  # Check every request for authorization
  check_authorization :unless => :devise_controller?

  # Redirect to root on authorization fail
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

end
