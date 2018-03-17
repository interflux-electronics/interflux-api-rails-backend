# == Schema Information
#
# Table name: products
#
#  id               :uuid             not null, primary key
#  name             :string
#  slug             :string
#  public           :boolean          default(FALSE)
#  pitch            :text
#  body             :text
#  avatar_image_id  :uuid
#  main_category_id :uuid
#  sub_category_id  :uuid
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Product < ApplicationRecord
  belongs_to :main_category, class_name: 'ProductCategory', foreign_key: 'main_category_id', optional: true
  belongs_to :sub_category, class_name: 'ProductCategory', foreign_key: 'sub_category_id', optional: true
  belongs_to :avatar_image, class_name: 'Image', foreign_key: 'avatar_image_id', optional: true

  has_many :product_translations
  has_many :images, as: :image_owner

  scope :which_are_public, -> () { where(public: true) }
  scope :where_main_category, ->(slug) { where(main_category: ProductCategory.where(slug: slug)) }
  scope :where_sub_category, ->(slug) { where(sub_category: ProductCategory.where(slug: slug)) }

  before_save :generate_slug

  private

  def generate_slug
    self.slug = name.parameterize(preserve_case: true)
  end
end
