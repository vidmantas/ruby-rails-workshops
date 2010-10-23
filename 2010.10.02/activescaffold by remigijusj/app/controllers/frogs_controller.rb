class FrogsController < ApplicationController
  
  # configuration
  active_scaffold do
    self.label = "Frogs list"
    
    columns[:created_at].label = "Sukurta"
    
    list.columns = [:name, :color, :swamp, :count, :price, :created_at]
    
    create.link.page = true
  end
  
end
