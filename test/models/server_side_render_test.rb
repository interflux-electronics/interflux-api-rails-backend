# == Schema Information
#
# Table name: server_side_renders
#
#  id         :uuid             not null, primary key
#  host       :string
#  ip         :string
#  referrer   :string
#  user_agent :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  visit_id   :uuid
#
require "test_helper"

class ServerSideRenderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
