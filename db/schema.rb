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

ActiveRecord::Schema.define(:version => 20110821012130) do

  create_table "constants", :force => true do |t|
    t.decimal  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluations", :force => true do |t|
    t.integer  "gradeing_scale_id"
    t.integer  "formula_id"
    t.integer  "report_definition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formula_items", :force => true do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.integer  "formula_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formulas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", :force => true do |t|
    t.string   "name"
    t.float    "value"
    t.integer  "grading_scale_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grading_scales", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "metric_snapshots", :force => true do |t|
    t.integer  "metric_id"
    t.integer  "project_id"
    t.decimal  "value"
    t.datetime "datetime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "metrics", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "source"
    t.integer  "direction"
    t.boolean  "qualitative"
    t.string   "val_type"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operators", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_report_definitions", :force => true do |t|
    t.integer  "project_id"
    t.integer  "report_definition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.integer  "external_id"
    t.string   "version"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_definitions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", :force => true do |t|
    t.integer  "report_definition_id"
    t.integer  "formula_id"
    t.integer  "grading_scale_id"
    t.integer  "grade_id"
    t.float    "decimal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
