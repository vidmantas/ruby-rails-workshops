# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110114145454) do

  create_table "animal_translations", :force => true do |t|
    t.integer  "animal_id"
    t.string   "locale"
    t.text     "description"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "description_auto_translated"
    t.boolean  "title_auto_translated"
  end

  add_index "animal_translations", ["animal_id"], :name => "index_animal_translations_on_animal_id"

  create_table "animals", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vegetable_translations", :force => true do |t|
    t.integer  "vegetable_id"
    t.string   "locale"
    t.text     "description"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "description_auto_translated"
    t.boolean  "title_auto_translated"
  end

  add_index "vegetable_translations", ["vegetable_id"], :name => "index_vegetable_translations_on_vegetable_id"

  create_table "vegetables", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
