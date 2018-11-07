# == Schema Information
#
# Table name: leads
#
#  id         :uuid             not null, primary key
#  name       :string
#  company    :string
#  email      :string
#  mobile     :string
#  message    :string
#  purpose    :string
#  source     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class LeadTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
