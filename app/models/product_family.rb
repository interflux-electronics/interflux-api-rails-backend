# == Schema Information
#
# Table name: product_families
#
#  slug        :string           not null, primary key
#  name_single :string
#  name_plural :string
#  public      :boolean          default(FALSE)
#  order       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ProductFamily < ApplicationRecord
  has_many :products
end
