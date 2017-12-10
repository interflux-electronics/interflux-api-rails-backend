# == Schema Information
#
# Table name: product_groups
#
#  id     :integer          not null, primary key
#  single :string
#  plural :string
#  slug   :string
#

class ProductGroup < ApplicationRecord
  has_many :products
  has_many :product_sub_group
end
