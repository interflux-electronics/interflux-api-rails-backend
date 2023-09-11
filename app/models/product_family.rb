class ProductFamily < ApplicationRecord
  belongs_to :product_family, optional: true
  alias_attribute :parent, :product_family

  # TODO: does not fetch all sub and main families...
  has_many :products
  has_many :product_uses, through: :products
  has_many :uses, through: :product_uses

  # TODO: deprecate product family images
  has_many :product_family_images
  has_many :images, through: :product_family_images, source: :image

  def main_family?
    parent.nil?
  end

  def sub_family?
    parent.present?
  end
end
