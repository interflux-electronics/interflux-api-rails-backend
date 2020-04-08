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
#  image_id          :uuid
#

class Product < ApplicationRecord
  belongs_to :product_family
  alias_attribute :family, :product_family

  belongs_to :image, optional: true
  alias_attribute :avatar, :image

  has_many :product_features
  has_many :features, through: :product_features, source: :feature

  has_many :product_images
  has_many :images, through: :product_images, source: :image

  has_many :product_uses
  has_many :uses, through: :product_uses, source: :use

  has_many :product_variants
  has_many :variants, through: :product_variants, source: :product

  has_many :product_containers
  has_many :containers, through: :product_containers, source: :container

  has_many :product_documents
  has_many :documents, through: :product_documents, source: :document
end
