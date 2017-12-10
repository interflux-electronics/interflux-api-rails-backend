# == Schema Information
#
# Table name: products
#
#  id                   :integer          not null, primary key
#  name                 :string
#  slug                 :string
#  product_group_id     :integer
#  product_sub_group_id :integer
#  public               :boolean          default(FALSE)
#  pitch                :text
#  body                 :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Product < ApplicationRecord
  belongs_to :product_group, optional: true
  belongs_to :product_sub_group, optional: true

  # has_many :documents
  # has_many :product_translations
  # has_many :images
  # has_many :processes
  # has_many :uses
  # has_many :related_products
  # has_many :related_articles

  # validates :name, presence: true, uniqueness: true
  # validates :slug, presence: true, uniqueness: true

  # before_validation do
  #   create_slug if slug.nil?
  # end

  # def create_slug
  #   return if name.blank?
  #   new_slug = name.parameterize # TODO: Allow capitals
  #   slug_exists = Product.exists?(slug: new_slug)
  #   self.slug = new_slug unless slug_exists
  # end
end
