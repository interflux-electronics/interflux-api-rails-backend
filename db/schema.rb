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

ActiveRecord::Schema.define(version: 20190610050435) do

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

  create_table "containers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_containers_on_name", unique: true
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

  create_table "features", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "text"
    t.string "icon"
    t.text "gist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_features_on_slug", unique: true
    t.index ["text"], name: "index_features_on_text", unique: true
  end

  create_table "images", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "cdn_path"
    t.string "sizes"
    t.string "formats"
    t.string "tag_long"
    t.string "tag_short"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cdn_path"], name: "index_images_on_cdn_path", unique: true
    t.index ["tag_long"], name: "index_images_on_tag_long", unique: true
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
  end

  create_table "product_complementary_products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id"
    t.uuid "complement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["complement_id"], name: "index_product_complementary_products_on_complement_id"
    t.index ["product_id"], name: "index_product_complementary_products_on_product_id"
  end

  create_table "product_complements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id"
    t.uuid "complement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["complement_id"], name: "index_product_complements_on_complement_id"
    t.index ["product_id"], name: "index_product_complements_on_product_id"
  end

  create_table "product_documents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id"
    t.uuid "document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_product_documents_on_document_id"
    t.index ["product_id"], name: "index_product_documents_on_product_id"
  end

  create_table "product_families", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "code"
    t.string "name_single"
    t.string "name_plural"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name_plural"], name: "index_product_families_on_name_plural", unique: true
    t.index ["name_single"], name: "index_product_families_on_name_single", unique: true
    t.index ["slug"], name: "index_product_families_on_slug", unique: true
  end

  create_table "product_features", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id"
    t.uuid "feature_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_id"], name: "index_product_features_on_feature_id"
    t.index ["product_id"], name: "index_product_features_on_product_id"
  end

  create_table "product_images", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id"
    t.uuid "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_id"], name: "index_product_images_on_image_id"
    t.index ["product_id"], name: "index_product_images_on_product_id"
  end

  create_table "product_processes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id"
    t.uuid "soldering_process_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_processes_on_product_id"
    t.index ["soldering_process_id"], name: "index_product_processes_on_soldering_process_id"
  end

  create_table "product_related_articles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id"
    t.uuid "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_product_related_articles_on_article_id"
    t.index ["product_id"], name: "index_product_related_articles_on_product_id"
  end

  create_table "product_substitutes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id"
    t.uuid "substitute_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_substitutes_on_product_id"
    t.index ["substitute_id"], name: "index_product_substitutes_on_substitute_id"
  end

  create_table "product_variants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "code"
    t.string "name"
    t.uuid "product_id"
    t.uuid "container_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_product_variants_on_code", unique: true
    t.index ["container_id"], name: "index_product_variants_on_container_id"
    t.index ["name"], name: "index_product_variants_on_name"
    t.index ["product_id"], name: "index_product_variants_on_product_id"
    t.index ["slug"], name: "index_product_variants_on_slug", unique: true
  end

  create_table "product_videos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id"
    t.uuid "video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_videos_on_product_id"
    t.index ["video_id"], name: "index_product_videos_on_video_id"
  end

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "code"
    t.string "name"
    t.boolean "public", default: false
    t.boolean "deprecated", default: false
    t.boolean "orderable", default: false
    t.boolean "popular", default: false
    t.boolean "new", default: false
    t.uuid "product_family_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_products_on_code", unique: true
    t.index ["deprecated"], name: "index_products_on_deprecated"
    t.index ["name"], name: "index_products_on_name", unique: true
    t.index ["new"], name: "index_products_on_new"
    t.index ["orderable"], name: "index_products_on_orderable"
    t.index ["popular"], name: "index_products_on_popular"
    t.index ["product_family_id"], name: "index_products_on_product_family_id"
    t.index ["public"], name: "index_products_on_public"
    t.index ["slug"], name: "index_products_on_slug", unique: true
  end

  create_table "soldering_processes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_soldering_processes_on_name", unique: true
    t.index ["slug"], name: "index_soldering_processes_on_slug", unique: true
  end

  create_table "tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_tags_on_slug", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.uuid "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "videos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "cdn_path"
    t.string "sizes"
    t.string "formats"
    t.string "tag_long"
    t.string "tag_short"
    t.string "poster_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cdn_path"], name: "index_videos_on_cdn_path", unique: true
    t.index ["tag_long"], name: "index_videos_on_tag_long", unique: true
  end

end
