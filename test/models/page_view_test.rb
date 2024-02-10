# == Schema Information
#
# Table name: page_views
#
#  id         :uuid             not null, primary key
#  path       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class PageViewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
