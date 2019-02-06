# == Schema Information
#
# Table name: product_features
#
#  id         :uuid             not null, primary key
#  slug       :string
#  text       :string
#  public     :boolean          default(FALSE)
#  image_id   :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductFeature < ApplicationRecord
  belongs_to :product
  belongs_to :feature
end
