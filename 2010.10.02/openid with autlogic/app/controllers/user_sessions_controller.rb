class UserSessionsController < ApplicationController

  before_filter :require_no_user, :only => [ :new, :create ]
  before_filter :require_user, :only => [ :destroy ]

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new params[:user_session]
    @user_session.save do |result|
      if result
        flash[:notice] = "Yay"
        redirect_back_or_default users_url

      else
      flash[:error] = "WTF?"
      render :action => :new
      end
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Yay"
    redirect_back_or_default users_url
  end

end
