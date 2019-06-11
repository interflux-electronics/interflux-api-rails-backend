# == Schema Information
#
# Table name: products
#
#  id                :uuid             not null, primary key
#  slug              :string
#  code              :string
#  name              :string
#  public            :boolean          default(FALSE)
#  deprecated        :boolean          default(FALSE)
#  orderable         :boolean          default(FALSE)
#  popular           :boolean          default(FALSE)
#  new               :boolean          default(FALSE)
#  product_family_id :uuid
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Product < ApplicationRecord
  belongs_to :product_family

  has_many :containers, through: :product_variants
  has_many :images, through: :product_images, source: :image
  has_many :product_images
  has_many :product_uses
  has_many :product_variants
  has_many :uses, through: :product_uses, source: :use

  alias_attribute :family, :product_family
  alias_attribute :variants, :product_variants
end
