# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20121204064952) do

  create_table "accessory_dependencies", :force => true do |t|
    t.integer  "unit_id",                                  :null => false
    t.integer  "accessory_category_id",                    :null => false
    t.boolean  "optional",              :default => false, :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "title",      :limit => 100,                                  :null => false
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.string   "type",                      :default => "EquipmentCategory", :null => false
  end

  create_table "er_hours", :force => true do |t|
    t.time     "starts_at",          :null => false
    t.time     "ends_at",            :null => false
    t.integer  "semester_id",        :null => false
    t.integer  "associated_hour_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.date     "day"
  end

  add_index "er_hours", ["associated_hour_id"], :name => "index_er_hours_on_associated_hour_id"

  create_table "packages", :force => true do |t|
    t.string   "title",                  :limit => 200, :null => false
    t.integer  "max_reservation_period"
    t.integer  "user_id",                               :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "packages_units", :force => true do |t|
    t.integer  "unit_id",    :null => false
    t.integer  "package_id", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reservations", :force => true do |t|
    t.date     "starts_at",                :null => false
    t.date     "ends_at",                  :null => false
    t.string   "status",     :limit => 30, :null => false
    t.text     "notes"
    t.integer  "user_id",                  :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "reserved_units", :force => true do |t|
    t.integer  "unit_id",        :null => false
    t.integer  "reservation_id", :null => false
    t.integer  "package_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "semesters", :force => true do |t|
    t.date     "starts_at",  :null => false
    t.date     "ends_at",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "units", :force => true do |t|
    t.boolean  "active",                                :default => true,        :null => false
    t.string   "status",                 :limit => 20,                           :null => false
    t.string   "name",                   :limit => 100
    t.string   "brand",                  :limit => 100
    t.string   "model",                  :limit => 100
    t.string   "serial",                 :limit => 100
    t.integer  "max_reservation_period"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "category_id"
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
    t.text     "notes"
    t.string   "type",                                  :default => "Equipment", :null => false
  end

  create_table "users", :force => true do |t|
    t.boolean  "active",                         :default => true
    t.string   "punet",            :limit => 8,                    :null => false
    t.integer  "pu_student_id"
    t.integer  "strikes",                        :default => 0
    t.boolean  "can_reserve",                    :default => true
    t.text     "notes"
    t.string   "password_digest"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.string   "email",                                            :null => false
    t.string   "permission_level", :limit => 50,                   :null => false
  end

end
