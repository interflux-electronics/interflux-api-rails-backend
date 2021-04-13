class Container < ApplicationRecord
  has_many :product_variants

  alias_attribute :variants, :product_variants
end
