require 'spec_helper'

describe ProfilesController do

  describe "new" do
    it "should be success" do
      get :new
      response.should be_success
    end
  end

  describe "show" do
    context "without profile" do
      it "should redirect" do
        get "show", :id => 1
        response.should be_redirect
      end
    end

    context "with profile" do
      before do
        Profile.should_receive(:find).with(1).and_return(@profile = mock_model(Profile))
      end

      it "should get profile and be success" do
        get :show, :id => 1
        response.should be_success
      end

      # I think this is bad practice. But you will stumble upon this once in a while
      context "view" do
        render_views # integrate_views in rails 2
        before { @profile.stub!(:name).and_return("Profile") }

        it "should display match name on match" do
          @profile.should_receive(:profile).twice.and_return(@match = mock_model(Profile))
          @match.stub!(:name).and_return("Match")
          get "show", :id => 1
          response.should contain("Profile your one-in-a-million is Match") # webrat sugar
          response.should_not contain("Sorry, Profile. Be patient") # webrat sugar
        end

        it "should display sorry on no match" do
          @profile.should_receive(:profile).and_return(nil)
          get :show, :id => 1
          response.should_not contain("your one-in-a-million is") # webrat sugar
          response.should contain("Sorry, Profile. Be patient") # webrat sugar
        end
      end
    end
  end

  describe "create" do
    before do
      @params = [:create, {:profile => {"id" => 1, "name" => "Name", "number" => 5, "sex" => false}}]
      Profile.should_receive(:new).with(@params[1][:profile]).and_return(@profile = mock_model(Profile))
    end

    it "should render profiles/new on invalid" do
      @profile.should_receive(:save).and_return(false)
      get *@params
      response.should be_success
      response.should render_template("profiles/new")
    end

    it "should redirect to profile if valid" do
      @profile.stub!(:id).and_return(1)
      @profile.should_receive(:save).and_return(true)
      get *@params
      response.should be_redirect
      response.should redirect_to(profile_path(1))
    end
  end

  context "oauth" do
    before do
      OAuth::Consumer.should_receive(:new).and_return(@oauth = mock)
      @oauth.should_receive(:get_request_token).and_return(@rtoken = mock)
      Profile.should_receive(:find).with(1).and_return(@profile = mock_model(Profile))
    end

    describe "oauth_create" do
      before do
        controller.should_receive(:clear_session).and_return(true)
      end

      it "should clear session and redirect to rtoken authorize url" do
        @rtoken.should_receive(:authorize_url).and_return("http://great.url.com")
        get :oauth_create, {:id => 1}
        response.should be_redirect
        response.should redirect_to("http://great.url.com")
      end

      it "should redirect to profile on error" do
        @rtoken.should_receive(:authorize_url).and_raise("OAuth error")
        get :oauth_create, {:id => 1}
        controller.flash[:notice].should == "External failure"
        response.should be_redirect
        response.should redirect_to(@profile)
      end
    end

    describe "oauth_finalize" do
      it "should redirect to update status on success" do
        @rtoken.should_receive(:get_access_token).and_return("access token")
        controller.should_receive(:clear_session).and_return(true)
        get :oauth_finalize, {:id => 1}
        response.should be_redirect
        response.should redirect_to(update_status_profile_path(@profile))
      end

      it "should redirect to profile on error" do
        @rtoken.should_receive(:get_access_token).and_raise("OAuth error")
        get :oauth_finalize, {:id => 1}
        controller.flash[:notice].should == "External failure"
        response.should be_redirect
        response.should redirect_to(profile_path(@profile))
      end
    end

    # homework: describe "update_status"
  end
end

