# == Schema Information
#
# Table name: product_categories
#
#  id                 :uuid             not null, primary key
#  slug               :string
#  name_plural        :string
#  name_single        :string
#  parent_category_id :uuid
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class ProductCategorySerializer < ApplicationSerializer
  attributes :slug,
             :name_plural,
             :name_single

  belongs_to :parent_category, record_type: :product_category
end
