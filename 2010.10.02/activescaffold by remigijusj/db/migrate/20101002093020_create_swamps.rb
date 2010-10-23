class CreateSwamps < ActiveRecord::Migration
  def self.up
    create_table :swamps do |t|
      t.string :name
      t.float  :size
      t.float  :humidity
      
      t.timestamps
    end
    
    add_column :frogs, :swamp_id, :integer
  end

  def self.down
    drop_table :swamps
    
    remove_column :frogs, :swamp_id
  end
end
