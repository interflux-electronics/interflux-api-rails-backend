class Document < ApplicationRecord
  belongs_to :document_category, optional: true
  alias_attribute :category, :document_category

  has_many :cdn_files
  alias_attribute :files, :cdn_files

  has_many :product_documents
  has_many :products, through: :product_documents, source: :product
end
