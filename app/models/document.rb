# == Schema Information
#
# Table name: documents
#
#  path                 :string           not null, primary key
#  name                 :string
#  language_id          :string
#  document_category_id :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  variations           :string
#

class Document < ApplicationRecord
  belongs_to :document_category
  alias_attribute :category, :document_category

  has_many :cdn_files
  alias_attribute :files, :cdn_files

  has_many :product_documents
  has_many :products, through: :product_documents, source: :product
end
