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

ActiveRecord::Schema.define(version: 20181213025832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "article_related_articles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "article_id"
    t.uuid "related_article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_article_related_articles_on_article_id"
    t.index ["related_article_id"], name: "index_article_related_articles_on_related_article_id"
  end

  create_table "articles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "title"
    t.string "tease"
    t.uuid "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_articles_on_author_id"
    t.index ["slug"], name: "index_articles_on_slug", unique: true
    t.index ["title"], name: "index_articles_on_title", unique: true
  end

  create_table "authors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "tagline"
    t.uuid "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_authors_on_person_id"
  end

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

  create_table "languages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "name_english"
    t.string "name_native"
    t.boolean "supported"
    t.index ["slug"], name: "index_languages_on_slug", unique: true
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

  create_table "people", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "name_single"
    t.string "name_plural"
    t.uuid "parent_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name_plural"], name: "index_product_groups_on_name_plural", unique: true
    t.index ["name_single"], name: "index_product_groups_on_name_single", unique: true
    t.index ["parent_group_id"], name: "index_product_groups_on_parent_group_id"
    t.index ["slug"], name: "index_product_groups_on_slug", unique: true
  end

  create_table "product_related_articles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id"
    t.uuid "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_product_related_articles_on_article_id"
    t.index ["product_id"], name: "index_product_related_articles_on_product_id"
  end

  create_table "product_related_products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id"
    t.uuid "related_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_related_products_on_product_id"
    t.index ["related_product_id"], name: "index_product_related_products_on_related_product_id"
  end

  create_table "product_translations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.string "pitch"
    t.uuid "product_id"
    t.uuid "language_id"
    t.index ["slug"], name: "index_product_translations_on_slug", unique: true
  end

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.string "pitch"
    t.boolean "public", default: false
    t.uuid "main_group_id"
    t.uuid "sub_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["main_group_id"], name: "index_products_on_main_group_id"
    t.index ["name"], name: "index_products_on_name", unique: true
    t.index ["public"], name: "index_products_on_public"
    t.index ["slug"], name: "index_products_on_slug", unique: true
    t.index ["sub_group_id"], name: "index_products_on_sub_group_id"
  end

end
