class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :logged_in?, :current_user

  def logged_in?
    not current_user.nil?
  end

  def current_user
    @current_user ||= User.where(:id => session[:user]).first if session[:user].present?
  end

  def current_user=(user)
    session[:user] = user.is_a?(User) ? user.id : user
  end

end
