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

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
