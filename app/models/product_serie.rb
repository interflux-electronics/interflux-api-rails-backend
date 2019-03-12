class ProductSerie < ApplicationRecord
  belongs_to :product_family

  has_many :product_variants
  has_many :containers, through: :product_variants

  alias_attribute :family, :product_family
  alias_attribute :variants, :product_variants
end
