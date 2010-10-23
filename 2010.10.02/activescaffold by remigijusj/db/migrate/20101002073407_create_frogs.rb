class CreateFrogs < ActiveRecord::Migration
  def self.up
    create_table :frogs do |t|
      t.string :name
      t.integer :count

      t.timestamps
    end
  end

  def self.down
    drop_table :frogs
  end
end
