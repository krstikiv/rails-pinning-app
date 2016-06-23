class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :require_login

  def current_user
    @user ||= User.where("id=?", session[:user_id]).first
  end

  def logged_in?
    !current_user.nil? && !current_user.id.nil?
  end

   def require_login
    if !logged_in?
      redirect_to login_path
    end
  end

end
