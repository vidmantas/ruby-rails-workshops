class AddFrogsAttrs < ActiveRecord::Migration
  def self.up
    add_column :frogs, :birth_date, :date
    add_column :frogs, :color, :string
    add_column :frogs, :price, :float
  end

  def self.down
    remove_column :frogs, :birth_date
    remove_column :frogs, :color
    remove_column :frogs, :price
  end
end
