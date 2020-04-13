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
#  public      :boolean          default(FALSE)
#  order       :integer
#

class ProductFamily < ApplicationRecord
  has_many :products
end
