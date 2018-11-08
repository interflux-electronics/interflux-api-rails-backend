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

ActiveRecord::Schema.define(version: 20181108031028) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "countries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name"
    t.text "native_name"
    t.text "region"
    t.text "subregion"
    t.text "alpha_2_code"
    t.text "alpha_3_code"
    t.text "numeric_code"
    t.text "flag"
    t.text "latlng"
    t.decimal "area"
    t.decimal "population"
    t.text "languages"
    t.text "timezones"
    t.text "currencies"
    t.text "top_level_domains"
    t.text "calling_codes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name"
    t.text "company"
    t.text "email"
    t.text "mobile"
    t.text "message"
    t.text "purpose"
    t.text "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "country_id"
    t.uuid "ip_country_id"
    t.text "ip_region"
    t.text "ip_city"
    t.text "ip"
  end

end
