class WelcomeController < ApplicationController
  def index
  	raise "My error"
  	render :text => 'ok'
  end
end
