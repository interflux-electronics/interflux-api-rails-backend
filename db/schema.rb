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

ActiveRecord::Schema.define(version: 20_181_004_233_234) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'
  enable_extension 'pgcrypto'

  create_table 'countries', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.string 'native_name'
    t.string 'region'
    t.string 'subregion'
    t.string 'alpha_2_code'
    t.string 'alpha_3_code'
    t.string 'numeric_code'
    t.string 'flag'
    t.string 'latlng'
    t.decimal 'area'
    t.decimal 'population'
    t.string 'languages'
    t.string 'timezones'
    t.string 'currencies'
    t.string 'top_level_domains'
    t.string 'calling_codes'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
