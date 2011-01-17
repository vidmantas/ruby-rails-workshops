class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :name
      t.integer :number
      t.boolean :sex
      t.integer :profile_id

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end

