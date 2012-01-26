class CreateAnimals < ActiveRecord::Migration
  def self.up
    create_table :animals do |t|
      #t.string :title
      #t.text :description

      t.timestamps
    end
    
    Animal.create_translation_table! :title => :string, :description => :text
  end

  def self.down
    drop_table :animals
    Animal.drop_translation_table!
  end
end
