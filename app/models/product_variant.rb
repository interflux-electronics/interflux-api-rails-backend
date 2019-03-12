# == Schema Information
#
# Table name: product_variants
#
#  id           :uuid             not null, primary key
#  slug         :string
#  code         :string
#  name         :string
#  public       :boolean          default(FALSE)
#  continued    :boolean          default(TRUE)
#  product_id   :uuid
#  container_id :uuid
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ProductVariant < ApplicationRecord
  belongs_to :product_serie
  belongs_to :container, optional: true
end
