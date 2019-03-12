# == Schema Information
#
# Table name: product_families
#
#  id          :uuid             not null, primary key
#  slug        :string
#  code        :string
#  name_single :string
#  name_plural :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ProductFamily < ApplicationRecord
  has_many :product_series
end
