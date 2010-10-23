class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Acl9::AccessDenied, :with => :access_denied

  def current_user
    User.first || User.create({:username => 'e'})
  end

  def access_denied
    redirect_to 'http://delfi.lt/'
  end
end
