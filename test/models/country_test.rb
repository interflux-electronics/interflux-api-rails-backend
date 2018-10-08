# == Schema Information
#
# Table name: countries
#
#  id                :uuid             not null, primary key
#  name              :string
#  native_name       :string
#  region            :string
#  subregion         :string
#  alpha_2_code      :string
#  alpha_3_code      :string
#  numeric_code      :string
#  flag              :string
#  latlng            :string
#  area              :decimal(, )
#  population        :decimal(, )
#  languages         :string
#  timezones         :string
#  currencies        :string
#  top_level_domains :string
#  calling_codes     :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
