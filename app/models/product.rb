# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id           :integer          not null, primary key
#  public       :boolean          default(FALSE)
#  name         :string
#  pitch        :string
#  product_type :string
#  slug         :string
#  corpus       :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Product < ApplicationRecord
  # has_one :product_type

  has_many :documents
  has_many :product_translations
  # has_many :images
  # has_many :processes
  # has_many :uses
  # has_many :related_products
  # has_many :related_articles

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
  validates :product_type, presence: true

  before_validation do
    create_slug if slug.nil?
  end

  def create_slug
    return if name.blank?
    new_slug = name.parameterize # TODO: Allow capitals
    slug_exists = Product.exists?(slug: new_slug)
    self.slug = new_slug unless slug_exists
  end
end
