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

ActiveRecord::Schema.define(version: 20210220064858) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "article_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_article_categories_on_name", unique: true
    t.index ["slug"], name: "index_article_categories_on_slug", unique: true
  end

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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "body"
    t.date "date"
    t.uuid "article_category_id"
    t.index ["slug"], name: "index_articles_on_slug", unique: true
    t.index ["title"], name: "index_articles_on_title", unique: true
  end

  create_table "cdn_files", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_id"
    t.string "document_id"
  end

  create_table "companies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "business_name"
    t.string "address"
    t.string "emails"
    t.string "phone"
    t.string "fax"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "legal_name"
    t.string "website"
    t.boolean "public"
    t.integer "order"
    t.string "email_general"
    t.string "email_support"
    t.string "email_orders"
    t.string "email_accounting"
    t.index ["business_name"], name: "index_companies_on_business_name", unique: true
    t.index ["country_id"], name: "index_companies_on_country_id"
    t.index ["slug"], name: "index_companies_on_slug", unique: true
  end

  create_table "company_markets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "company_id"
    t.string "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_members", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "company_id"
    t.uuid "person_id"
    t.string "title"
    t.string "email"
    t.string "phone"
    t.boolean "public", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "public_title", default: false
    t.boolean "public_email", default: false
    t.boolean "public_phone", default: false
    t.index ["company_id"], name: "index_company_members_on_company_id"
    t.index ["person_id"], name: "index_company_members_on_person_id"
  end

  create_table "containers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_containers_on_name", unique: true
  end

  create_table "countries", primary_key: "two_letter_code", id: :string, force: :cascade do |t|
    t.string "name_english"
    t.string "name_native"
    t.string "three_letter_code"
    t.string "numeric_code"
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

  create_table "currencies", primary_key: "code", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "document_categories", primary_key: "slug", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "gist"
    t.string "icon"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", primary_key: "path", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "language_id"
    t.string "document_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "variations"
    t.boolean "public", default: false
  end

  create_table "employees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "company_id"
    t.uuid "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
    t.index ["person_id"], name: "index_employees_on_person_id"
  end

  create_table "features", primary_key: "slug", id: :string, force: :cascade do |t|
    t.string "text"
    t.string "icon"
    t.string "gist"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_page"
  end

  create_table "images", primary_key: "path", id: :string, force: :cascade do |t|
    t.string "sizes"
    t.string "formats"
    t.string "caption"
    t.string "alt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "company_id"
    t.string "variations"
  end

  create_table "languages", primary_key: "two_letter_code", id: :string, force: :cascade do |t|
    t.string "name_english"
    t.string "name_native"
    t.string "three_letter_code"
    t.boolean "public", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "chinese_name"
    t.string "email"
    t.string "phone"
    t.boolean "male"
    t.string "full_name"
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
    t.string "product_id"
    t.string "document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rank_among_products"
    t.integer "rank_among_documents"
  end

  create_table "product_families", primary_key: "slug", id: :string, force: :cascade do |t|
    t.string "name_single"
    t.string "name_plural"
    t.boolean "public", default: false
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gist"
  end

  create_table "product_family_images", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "product_family_id"
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rank_among_families"
    t.integer "rank_among_images"
  end

  create_table "product_features", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "product_id"
    t.string "feature_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_images", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "product_id"
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rank"
    t.boolean "public"
  end

  create_table "product_qualities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "product_id"
    t.string "quality_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rank_among_products"
    t.integer "rank_among_qualities"
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

  create_table "product_uses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "product_id"
    t.string "use_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rank_among_products"
    t.integer "rank_among_uses"
  end

  create_table "product_videos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id"
    t.uuid "video_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_videos_on_product_id"
    t.index ["video_id"], name: "index_product_videos_on_video_id"
  end

  create_table "products", primary_key: "slug", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "product_family_id"
    t.string "image_id"
    t.string "label"
    t.text "pitch"
    t.text "properties"
    t.boolean "public", default: false
    t.boolean "orderable", default: false
    t.boolean "featured", default: false
    t.boolean "popular", default: false
    t.boolean "new", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "offline"
    t.string "superior_product_id"
    t.integer "rank_among_family"
  end

  create_table "qualities", primary_key: "slug", id: :string, force: :cascade do |t|
    t.string "text"
    t.string "icon"
    t.text "gist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_id"
  end

  create_table "tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_tags_on_slug", unique: true
  end

  create_table "use_images", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "use_id"
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rank_among_uses"
    t.integer "rank_among_images"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.uuid "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "uses", primary_key: "slug", id: :string, force: :cascade do |t|
    t.string "text"
    t.string "icon"
    t.text "gist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_id"
    t.integer "rank"
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

  create_table "webinar_invitees", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "webinar_id"
    t.uuid "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "webinars", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "topic"
    t.string "audience"
    t.string "url"
    t.boolean "public", default: false
    t.bigint "start_time"
    t.integer "duration"
    t.uuid "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
