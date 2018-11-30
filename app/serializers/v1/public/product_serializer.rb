# == Schema Information
#
# Table name: products
#
#  id               :uuid             not null, primary key
#  slug             :string
#  name             :string
#  pitch            :string
#  public           :boolean          default(FALSE)
#  product_group_id :uuid
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
module V1
  module Public
    class ProductSerializer < ApplicationSerializer
      include FastJsonapi::ObjectSerializer

      attributes :slug,
                 :name,
                 :pitch

      belongs_to :product_group
    end
  end
end
