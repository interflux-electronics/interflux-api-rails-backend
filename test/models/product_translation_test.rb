# frozen_string_literal: true

# == Schema Information
#
# Table name: product_translations
#
#  id         :integer          not null, primary key
#  product_id :integer
#  locale     :string
#  name       :string
#  corpus     :text
#  pitch      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ProductTranslationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
