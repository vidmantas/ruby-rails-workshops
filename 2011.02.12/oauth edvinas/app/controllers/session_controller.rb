class SessionController < ApplicationController
  def login
    if params[:user]
      user = User.where(:username => params[:user][:username]).first
      user ||= User.create(:username => params[:user][:username])

      session[:user] = user.id
      @user = user
    else
      @user = User.new
    end
  end

  def logout
    session[:user] = nil 
    redirect_to :action => :login
  end
end
