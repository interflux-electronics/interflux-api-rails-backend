# == Schema Information
#
# Table name: product_groups
#
#  id              :uuid             not null, primary key
#  slug            :string
#  name_single     :string
#  name_plural     :string
#  parent_group_id :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class ProductGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
