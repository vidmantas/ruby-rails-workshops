class ProfilesController < ApplicationController

  before_filter :only => [:oauth_create, :oauth_finalize] do
    require "oauth"
  end
  before_filter :get_profile, :only => [:oauth_create, :oauth_finalize, :update_status, :show]

  # GET /show
  # GET /show.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  # GET /profiles/new
  # GET /profiles/new.xml
  def new
    @profile = Profile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  # POST /profiles
  # POST /profiles.xml
  def create
    @profile = Profile.new(params[:profile])
    respond_to do |format|
      if @profile.save
        format.html { redirect_to(@profile) }
        format.xml  { render :xml => @profile, :status => :match, :location => @profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  def oauth_create
    clear_session
    redirect_to "#{rtoken.authorize_url}"
  rescue => e
    flash[:notice] = "External failure"
    redirect_to @profile
  end

  def oauth_finalize
    access_token = rtoken.get_access_token(:oauth_verifier => params[:oauth_verifier])
  rescue => e
    flash[:notice] = "External failure"
    redirect_to @profile
  else
    clear_session
    session['atoken'] = access_token
    redirect_to update_status_profile_path(@profile)
  end

  def update_status
    Twitter.configure do |config|
      config.consumer_key       = TWITTER_CONSUMER_KEY
      config.consumer_secret    = TWITTER_CONSUMER_SECRET
      config.oauth_token        = session['atoken'].token
      config.oauth_token_secret = session['atoken'].secret
    end
    client = Twitter::Client.new
    client.update("My one-in-a-million is #{@profile.profile.name}")
    flash[:notice] = "Twitter is very happy"
    render :action => "show"
  end

  private

  def clear_session
    session.delete('oauth')
    session.delete('rtoken')
  end

  def oauth
    session['oauth'] ||= OAuth::Consumer.new(
      TWITTER_CONSUMER_KEY, TWITTER_CONSUMER_SECRET,
      :request_token_url => "https://api.twitter.com/oauth/request_token",
      :access_token_url => "https://api.twitter.com/oauth/access_token",
      :authorize_url => "https://api.twitter.com/oauth/authorize")
  end

  def rtoken
    session['rtoken'] ||= oauth.get_request_token(:oauth_callback => oauth_finalize_profile_url(@profile))
  end

  def get_profile
    @profile = Profile.find(params[:id])
  end
end

