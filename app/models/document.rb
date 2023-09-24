# create_table "documents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
#   t.string "path", null: false
#   t.string "name"
#   t.string "language_id"
#   t.string "document_category_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.string "variations"
#   t.boolean "public", default: false
# end

class Document < ApplicationRecord
  belongs_to :document_category, optional: true
  alias_attribute :category, :document_category

  has_many :cdn_files, dependent: :destroy
  alias_attribute :files, :cdn_files

  has_many :product_documents, dependent: :destroy
  has_many :products, through: :product_documents, source: :product

  def sync_variations
    return if files.nil?
    return if files.none?

    # documents/products/Flexsol-903/TD-Flexsol-903-EN.pdf
    # documents/products/Flexsol-903/TD-Flexsol-903-DE.pdf
    # documents/products/Flexsol-903/TD-Flexsol-903-FR.pdf
    paths = files.map(&:path)

    # TD-Flexsol-903-EN.pdf
    # TD-Flexsol-903-DE.pdf
    # TD-Flexsol-903-FR.pdf
    file_names = paths.map { |p| p.split('/').last }

    # EN.pdf
    # DE.pdf
    # FR.pdf
    extensions = file_names.map { |p| p.split('-').last }

    # EN.pdf,DE.pdf,FR.pdf
    update!(variations: extensions.join(','))
  end
end
