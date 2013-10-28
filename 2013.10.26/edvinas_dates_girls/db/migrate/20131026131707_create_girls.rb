class CreateGirls < ActiveRecord::Migration
  def change
    create_table :girls do |t|
      t.string :name
      t.string :phone
      t.integer :stars

      t.timestamps
    end
  end
end
