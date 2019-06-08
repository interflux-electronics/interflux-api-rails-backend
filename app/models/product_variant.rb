# == Schema Information
#
# Table name: product_variants
#
#  id           :uuid             not null, primary key
#  slug         :string
#  code         :string
#  name         :string
#  product_id   :uuid
#  container_id :uuid
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ProductVariant < ApplicationRecord
  belongs_to :product
  belongs_to :container, optional: true
end
