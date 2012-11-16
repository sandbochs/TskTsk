class ApplicationController < ActionController::Base
  
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticated?
    !current_user.nil?
  end

  def authenticate_user!
    if !authenticated?
      redirect_to root_url, alert: 'Please login!'
    end
  end

  helper_method :current_user, :authenticated?, :authenticate_user!

end
