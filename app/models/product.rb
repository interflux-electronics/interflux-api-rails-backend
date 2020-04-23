# == Schema Information
#
# Table name: products
#
#  slug              :string           not null, primary key
#  name              :string
#  product_family_id :string
#  label             :string
#  pitch             :text
#  properties        :text
#  public            :boolean          default(FALSE)
#  orderable         :boolean          default(FALSE)
#  featured          :boolean          default(FALSE)
#  popular           :boolean          default(FALSE)
#  new               :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
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
