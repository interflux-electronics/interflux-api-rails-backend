# == Schema Information
#
# Table name: client_side_renders
#
#  id              :uuid             not null, primary key
#  host            :string
#  ip              :string
#  referrer        :string
#  user_agent      :string
#  viewport_height :integer
#  viewport_width  :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :uuid
#  visit_id        :uuid
#
require "test_helper"

class ClientSideRenderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
