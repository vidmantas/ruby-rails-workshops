class Vegetable < ActiveRecord::Base
  translates :title, :description
  
  validates :title, :presence => true
end
