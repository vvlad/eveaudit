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

ActiveRecord::Schema.define(version: 2018_05_13_104000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "affiliations", force: :cascade do |t|
    t.bigint "character_id"
    t.string "to_type"
    t.bigint "to_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_affiliations_on_character_id"
    t.index ["to_type", "to_id"], name: "index_affiliations_on_to_type_and_to_id"
  end

  create_table "alliances", id: :bigint, default: nil, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "audits", force: :cascade do |t|
    t.bigint "character_id"
    t.string "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token"
    t.string "refresh_token"
    t.datetime "expires_at"
    t.index ["character_id"], name: "index_audits_on_character_id"
  end

  create_table "characters", id: :bigint, default: nil, force: :cascade do |t|
    t.string "name"
    t.jsonb "granted_scopes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "alliance_id"
    t.bigint "corporation_id"
    t.string "description"
    t.datetime "birthday"
    t.string "gender"
    t.integer "race_id"
    t.integer "bloodline_id"
    t.integer "ancestry_id"
    t.float "security_status"
    t.integer "faction_id"
    t.index ["alliance_id"], name: "index_characters_on_alliance_id"
    t.index ["corporation_id"], name: "index_characters_on_corporation_id"
  end

  create_table "characters_corporations", id: false, force: :cascade do |t|
    t.bigint "corporation_id"
    t.bigint "character_id"
    t.index ["character_id"], name: "index_characters_corporations_on_character_id"
    t.index ["corporation_id"], name: "index_characters_corporations_on_corporation_id"
  end

  create_table "corporation_memberships", force: :cascade do |t|
    t.bigint "corporation_id"
    t.bigint "character_id"
    t.datetime "joined_at"
    t.datetime "leaved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_corporation_memberships_on_character_id"
    t.index ["corporation_id"], name: "index_corporation_memberships_on_corporation_id"
  end

  create_table "corporations", id: :bigint, default: nil, force: :cascade do |t|
    t.string "name", default: "Unkwnon"
    t.string "description"
    t.string "ticker"
    t.bigint "alliance_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "member_count"
    t.string "tax_rate"
    t.date "date_founded"
    t.bigint "ceo_id"
    t.string "creator_id"
    t.string "corporation_url"
    t.string "faction_id"
    t.string "home_station_id"
    t.bigint "shares"
    t.index ["alliance_id"], name: "index_corporations_on_alliance_id"
  end

  create_table "factions", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "corporation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["corporation_id"], name: "index_factions_on_corporation_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "character_id"
    t.bigint "sender_id"
    t.bigint "integer"
    t.string "sender_type", null: false
    t.string "text"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_notifications_on_character_id"
    t.index ["sender_id", "sender_type"], name: "index_notifications_on_sender_id_and_sender_type"
  end

  add_foreign_key "affiliations", "characters"
  add_foreign_key "audits", "characters"
  add_foreign_key "characters", "alliances"
  add_foreign_key "characters", "corporations"
  add_foreign_key "corporation_memberships", "characters"
  add_foreign_key "corporation_memberships", "corporations"
  add_foreign_key "corporations", "alliances"
  add_foreign_key "factions", "corporations"
  add_foreign_key "notifications", "characters"
end
