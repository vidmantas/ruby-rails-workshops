ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'

require_relative 'main'

include Rack::Test::Methods
def app; Sinatra::Application; end

describe "app root" do
  it "should return success" do
    get '/'
    #p last_request
    #p last_response
    assert last_response.ok?
    assert last_response.body['Remi 2012']
  end
end

describe Word do
  before do
    Word.destroy
  end
  
  describe "empty database" do
    it "should create a word" do
      Word.create(word: "Example")
      
      Word.all.size.must_equal 1
      Word.get(1).word.must_equal "Example"
    end
  end
end
