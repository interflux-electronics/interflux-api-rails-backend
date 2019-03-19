# == Schema Information
#
# Table name: product_documents
#
#  id               :uuid             not null, primary key
#  product_serie_id :uuid
#  document_id      :uuid
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class ProductDocument < ApplicationRecord
  belongs_to :product_serie
  belongs_to :document
end
