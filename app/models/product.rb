# == Schema Information
#
# Table name: products
#
#  id              :uuid             not null, primary key
#  slug            :string
#  code            :string
#  name            :string
#  public          :boolean          default(FALSE)
#  continued       :boolean          default(TRUE)
#  product_type_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Product < ApplicationRecord
  belongs_to :product_type
  has_one :product_family, through: :product_type

  has_many :product_variants
  has_many :containers, through: :product_variants
end
