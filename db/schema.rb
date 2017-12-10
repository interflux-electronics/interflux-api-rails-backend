

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

ActiveRecord::Schema.define(version: 20_171_130_101_905) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'contacts', force: :cascade do |t|
    t.string 'name'
    t.string 'company'
    t.string 'email'
    t.string 'website'
    t.string 'phone'
    t.string 'fax'
    t.string 'address'
    t.integer 'country_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'countries', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'documents', force: :cascade do |t|
    t.string 'name'
    t.string 'url'
    t.string 'document_type'
    t.string 'locale'
    t.boolean 'public'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'languages', force: :cascade do |t|
    t.string 'locale'
    t.string 'name_english'
    t.string 'name_native'
  end

  create_table 'product_groups', force: :cascade do |t|
    t.string 'single'
    t.string 'plural'
    t.string 'slug'
  end

  create_table 'product_sub_groups', force: :cascade do |t|
    t.integer 'product_group_id'
    t.string 'single'
    t.string 'plural'
    t.string 'slug'
  end

  create_table 'product_translations', force: :cascade do |t|
    t.integer 'product_id'
    t.string 'locale'
    t.string 'name'
    t.text 'body'
    t.text 'pitch'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'product_uses', force: :cascade do |t|
    t.string 'name'
  end

  create_table 'products', force: :cascade do |t|
    t.string 'name'
    t.string 'slug'
    t.integer 'product_group_id'
    t.integer 'product_sub_group_id'
    t.boolean 'public', default: false
    t.text 'pitch'
    t.text 'body'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'password_digest'
    t.boolean 'can_access_admin', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
