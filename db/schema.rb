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

ActiveRecord::Schema.define(version: 20151028125256) do

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "product_photo"
    t.string   "shop_name"
    t.integer  "shop_owner_id"
    t.boolean  "pro",           default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "remember_token"
    t.string   "password_digest"
    t.string   "type"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "shop_name"
    t.date     "birthday"
    t.string   "avatar"
    t.string   "passport_photo"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
