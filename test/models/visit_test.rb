# == Schema Information
#
# Table name: visits
#
#  id              :uuid             not null, primary key
#  host            :string
#  ip              :string
#  ip_isp          :string
#  is_bot          :boolean
#  is_interflux    :boolean
#  referrer        :string
#  user_agent      :string
#  viewport_height :integer
#  viewport_width  :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  ip_country_id   :string
#  user_id         :uuid
#
require "test_helper"

class VisitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
