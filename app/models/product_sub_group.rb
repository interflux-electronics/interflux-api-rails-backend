# frozen_string_literal: true

# == Schema Information
#
# Table name: product_sub_groups
#
#  id               :integer          not null, primary key
#  product_group_id :integer
#  single           :string
#  plural           :string
#  slug             :string
#

class ProductSubGroup < ApplicationRecord
  belongs_to :product_group
  has_many :products
end
