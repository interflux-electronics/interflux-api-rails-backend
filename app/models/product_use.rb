class ProductUse < ApplicationRecord
  belongs_to :product
  belongs_to :use

  # If :show_alternative_avatar is true then the frontend will prefer ProductUse.image over Product.image.
  alias_attribute :alternative_avatar, :image
  belongs_to :image
end
