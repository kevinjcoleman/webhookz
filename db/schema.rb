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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160129050314) do

  create_table "actions", force: :cascade do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "action_type"
    t.integer  "webhook_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "actions", ["webhook_id"], name: "index_actions_on_webhook_id"

  create_table "nations", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "nation_slug"
    t.string   "api_key"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "webhooks_count"
    t.boolean  "valid_api",      default: true
  end

  add_index "nations", ["user_id"], name: "index_nations_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "webhooks", force: :cascade do |t|
    t.string   "event"
    t.string   "external_id"
    t.string   "link"
    t.integer  "nation_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "active",      default: true
  end

  add_index "webhooks", ["external_id"], name: "index_webhooks_on_external_id"
  add_index "webhooks", ["nation_id"], name: "index_webhooks_on_nation_id"

end
