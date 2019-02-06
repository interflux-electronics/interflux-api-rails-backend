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

ActiveRecord::Schema.define(version: 20190205225756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "article_tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "article_id"
    t.uuid "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_article_tags_on_article_id"
    t.index ["tag_id"], name: "index_article_tags_on_tag_id"
  end

  create_table "articles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "title"
    t.boolean "public", default: false
    t.uuid "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_articles_on_person_id"
    t.index ["slug"], name: "index_articles_on_slug", unique: true
    t.index ["title"], name: "index_articles_on_title", unique: true
  end

  create_table "companies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.string "address"
    t.string "email"
    t.string "phone"
    t.string "fax"
    t.decimal "latitude"
    t.decimal "longitude"
    t.uuid "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_companies_on_country_id"
    t.index ["name"], name: "index_companies_on_name", unique: true
    t.index ["slug"], name: "index_companies_on_slug", unique: true
  end

  create_table "countries", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name_english"
    t.string "name_native"
    t.string "iso_3161_1_alpha_2_code"
    t.string "iso_3161_1_alpha_3_code"
    t.string "iso_3161_1_numeric_code"
    t.string "region"
    t.string "subregion"
    t.decimal "latitude"
    t.decimal "longitude"
    t.integer "area"
    t.integer "population"
    t.string "flag_url"
    t.string "timezones"
    t.string "top_level_domains"
    t.string "calling_codes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["iso_3161_1_alpha_2_code"], name: "index_countries_on_iso_3161_1_alpha_2_code", unique: true
    t.index ["iso_3161_1_alpha_3_code"], name: "index_countries_on_iso_3161_1_alpha_3_code", unique: true
    t.index ["iso_3161_1_numeric_code"], name: "index_countries_on_iso_3161_1_numeric_code", unique: true
    t.index ["name_english"], name: "index_countries_on_name_english", unique: true
    t.index ["name_native"], name: "index_countries_on_name_native", unique: true
  end

  create_table "country_currencies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "country_id"
    t.uuid "currency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_country_currencies_on_country_id"
    t.index ["currency_id"], name: "index_country_currencies_on_currency_id"
  end

  create_table "country_languages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "country_id"
    t.uuid "language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_country_languages_on_country_id"
    t.index ["language_id"], name: "index_country_languages_on_language_id"
  end

  create_table "currencies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "symbol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_currencies_on_code", unique: true
  end

  create_table "documents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "path"
    t.string "name"
    t.uuid "language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_documents_on_language_id"
    t.index ["name"], name: "index_documents_on_name", unique: true
    t.index ["path"], name: "index_documents_on_path", unique: true
  end

  create_table "employees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "company_id"
    t.uuid "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["person_id"], name: "index_employees_on_person_id"
  end

  create_table "images", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "path"
    t.string "text"
    t.string "sizes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["path"], name: "index_images_on_path", unique: true
    t.index ["text"], name: "index_images_on_text", unique: true
  end

  create_table "languages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name_english"
    t.string "name_native"
    t.string "iso_639_1_code"
    t.string "iso_639_2_code"
    t.boolean "public", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["iso_639_1_code"], name: "index_languages_on_iso_639_1_code", unique: true
    t.index ["iso_639_2_code"], name: "index_languages_on_iso_639_2_code", unique: true
    t.index ["public"], name: "index_languages_on_public"
  end

  create_table "leads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "company"
    t.string "email"
    t.string "mobile"
    t.text "message"
    t.string "purpose"
    t.string "source"
    t.string "ip_region"
    t.string "ip_city"
    t.string "ip"
    t.uuid "country_id"
    t.uuid "ip_country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_leads_on_country_id"
    t.index ["ip_country_id"], name: "index_leads_on_ip_country_id"
  end

  create_table "people", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.string "email"
    t.string "mobile"
    t.string "address"
    t.uuid "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_people_on_country_id"
    t.index ["email"], name: "index_people_on_email", unique: true
    t.index ["name"], name: "index_people_on_name", unique: true
    t.index ["slug"], name: "index_people_on_slug", unique: true
  end

  create_table "product_documents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id"
    t.uuid "document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_product_documents_on_document_id"
    t.index ["product_id"], name: "index_product_documents_on_product_id"
  end

  create_table "product_features", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "text"
    t.boolean "public", default: false
    t.uuid "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_id"], name: "index_product_features_on_image_id"
    t.index ["public"], name: "index_product_features_on_public"
    t.index ["slug"], name: "index_product_features_on_slug", unique: true
    t.index ["text"], name: "index_product_features_on_text", unique: true
  end

  create_table "product_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "name_single"
    t.string "name_plural"
    t.boolean "public", default: false
    t.uuid "parent_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name_plural"], name: "index_product_groups_on_name_plural", unique: true
    t.index ["name_single"], name: "index_product_groups_on_name_single", unique: true
    t.index ["parent_group_id"], name: "index_product_groups_on_parent_group_id"
    t.index ["public"], name: "index_product_groups_on_public"
    t.index ["slug"], name: "index_product_groups_on_slug", unique: true
  end

  create_table "product_images", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id"
    t.uuid "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_id"], name: "index_product_images_on_image_id"
    t.index ["product_id"], name: "index_product_images_on_product_id"
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

  create_table "product_variations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.uuid "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_product_variations_on_code", unique: true
  end

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.boolean "public", default: false
    t.uuid "product_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_products_on_name", unique: true
    t.index ["product_group_id"], name: "index_products_on_product_group_id"
    t.index ["public"], name: "index_products_on_public"
    t.index ["slug"], name: "index_products_on_slug", unique: true
  end

  create_table "tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_tags_on_slug", unique: true
  end

end
