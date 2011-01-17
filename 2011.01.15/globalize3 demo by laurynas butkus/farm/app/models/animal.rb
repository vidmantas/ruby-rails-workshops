class Animal < ActiveRecord::Base
  translates :title, :description
  
  #validates :title, :presence => true
end
