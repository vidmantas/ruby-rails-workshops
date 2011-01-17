class CreateVegetables < ActiveRecord::Migration
  def self.up
    create_table :vegetables do |t|
      t.timestamps
    end
    
    Vegetable.create_translation_table! :title => :string, :description => :text
  end

  def self.down
    drop_table :vegetables
    
    Vegetable.drop_translation_table!
  end
end
