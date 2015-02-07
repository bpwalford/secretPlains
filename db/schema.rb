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

ActiveRecord::Schema.define(version: 20150207202908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "differences", force: true do |t|
    t.integer  "original_id"
    t.integer  "altered_id"
    t.text     "plugins_intersection"
    t.integer  "plugins_lev"
    t.text     "user_agent_intersection"
    t.integer  "user_agent_lev"
    t.text     "browser_intersection"
    t.integer  "browser_lev"
    t.text     "fonts_intersection"
    t.decimal  "percent_font_match",      precision: 3, scale: 2
    t.boolean  "cookies"
    t.boolean  "language"
    t.boolean  "ip"
    t.boolean  "screen"
    t.boolean  "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fingerprints", force: true do |t|
    t.integer  "user_id"
    t.text     "plugins"
    t.text     "fonts"
    t.string   "user_agent"
    t.string   "browser_version"
    t.string   "cookies"
    t.string   "language"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip"
    t.string   "screen"
    t.string   "country"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

end
