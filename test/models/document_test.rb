# frozen_string_literal: true

# == Schema Information
#
# Table name: documents
#
#  id            :integer          not null, primary key
#  name          :string
#  url           :string
#  document_type :string
#  locale        :string
#  public        :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
