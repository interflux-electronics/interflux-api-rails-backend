# == Schema Information
#
# Table name: product_groups
#
#  id              :uuid             not null, primary key
#  slug            :string
#  name_single     :string
#  name_plural     :string
#  parent_group_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ProductGroup < ApplicationRecord
  has_many :product

  belongs_to :parent_group, class_name: 'ProductGroup', foreign_key: 'parent_group_id'

  validates :slug, presence: true, uniqueness: true
  validates :name_single, presence: true, uniqueness: true
  validates :name_plural, presence: true, uniqueness: true
end
