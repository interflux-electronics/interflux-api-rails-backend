# == Schema Information
#
# Table name: product_documents
#
#  id                   :uuid             not null, primary key
#  rank_among_documents :integer
#  rank_among_products  :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  document_id          :uuid
#  product_id           :string
#
class ProductDocument < ApplicationRecord
  belongs_to :product
  belongs_to :document
end
