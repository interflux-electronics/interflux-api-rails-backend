# == Schema Information
#
# Table name: containers
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Container < ApplicationRecord
  has_many :product_variants

  alias_attribute :variants, :product_variants
end
