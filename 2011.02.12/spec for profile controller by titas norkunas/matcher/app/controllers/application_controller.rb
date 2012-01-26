class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound do |e|
    logger.error e.inspect
    redirect_to root_path
  end
end
