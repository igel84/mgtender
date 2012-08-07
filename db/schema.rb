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

ActiveRecord::Schema.define(:version => 20120807110016) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories_users", :id => false, :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "category_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "inn"
    t.integer  "owner_form_id"
    t.integer  "sphere_id"
    t.string   "general_phone"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.string   "logo_file_name"
    t.datetime "logo_updated_at"
    t.boolean  "is_nds",            :default => false
    t.integer  "master_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "news", :force => true do |t|
    t.text     "html_content"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "title",        :default => ""
  end

  create_table "owner_forms", :force => true do |t|
    t.string   "name"
    t.boolean  "is_nds",     :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "propose_items", :force => true do |t|
    t.integer  "propose_id"
    t.integer  "tender_item_id"
    t.decimal  "price",          :precision => 10, :scale => 2
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "proposes", :force => true do |t|
    t.integer  "tender_id"
    t.integer  "tender_iteration_id"
    t.integer  "user_id"
    t.text     "note"
    t.integer  "delay",               :default => 0
    t.integer  "num_of_trans"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "spheres", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tender_attachments", :force => true do |t|
    t.integer  "tender_id"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.datetime "attach_updated_at"
    t.integer  "attach_file_size"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "tender_items", :force => true do |t|
    t.integer  "tender_id"
    t.string   "name"
    t.decimal  "price",      :precision => 10, :scale => 2
    t.float    "count",                                     :default => 1.0
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  create_table "tender_iterations", :force => true do |t|
    t.integer  "tender_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean  "is_ended",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "tender_requests", :force => true do |t|
    t.integer  "tender_id"
    t.integer  "user_id"
    t.boolean  "accepted_t",    :default => false
    t.boolean  "accepted_p",    :default => false
    t.string   "company_name"
    t.string   "company_email"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "tender_types", :force => true do |t|
    t.string   "name"
    t.text     "info"
    t.boolean  "is_iteration", :default => false
    t.boolean  "is_selling",   :default => true
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "tenders", :force => true do |t|
    t.integer  "user_id"
    t.string   "category_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "name"
    t.integer  "status",                                         :default => 0
    t.integer  "iteration_count",                                :default => 1
    t.text     "note"
    t.integer  "tender_type_id"
    t.decimal  "step",            :precision => 10, :scale => 2
    t.boolean  "closed",                                         :default => false
    t.decimal  "summ",            :precision => 10, :scale => 2
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.boolean  "admin",                           :default => false
    t.integer  "company_id"
    t.string   "name"
    t.string   "phone"
    t.string   "fname"
    t.string   "nname"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.datetime "photo_updated_at"
    t.integer  "photo_file_size"
    t.boolean  "accept_company",                  :default => false
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
  end

  add_index "users", ["activation_token"], :name => "index_users_on_activation_token"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

  create_table "winners", :id => false, :force => true do |t|
    t.integer  "tender_id"
    t.integer  "propose_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
