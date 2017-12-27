# == Schema Information
#
# Table name: products
#
#  id               :integer          not null, primary key
#  name             :string
#  slug             :string
#  public           :boolean          default(FALSE)
#  pitch            :text
#  body             :text
#  main_category_id :integer
#  sub_category_id  :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Product < ApplicationRecord
  belongs_to :main_category, class_name: 'ProductCategory', foreign_key: 'main_category_id', optional: true
  belongs_to :sub_category, class_name: 'ProductCategory', foreign_key: 'sub_category_id', optional: true

  scope :which_are_public, -> () { where(public: true) }
  scope :where_main_category, ->(slug) { where(main_category: ProductCategory.where(slug: slug)) }
  scope :where_sub_category, ->(slug) { where(sub_category: ProductCategory.where(slug: slug)) }
end
