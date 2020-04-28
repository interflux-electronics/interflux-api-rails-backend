# == Schema Information
#
# Table name: product_documents
#
#  id          :uuid             not null, primary key
#  product_id  :string
#  document_id :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ProductDocument < ApplicationRecord
  belongs_to :product
  belongs_to :document
end
