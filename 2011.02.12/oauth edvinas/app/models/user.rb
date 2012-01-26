class User < ActiveRecord::Base
  has_one :google, :class_name=>"GoogleToken", :dependent=>:destroy  
  def to_s
    username
  end
end
