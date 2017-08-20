# frozen_string_literal: true

# == Schema Information
#
# Table name: leads
#
#  id         :integer          not null, primary key
#  name       :string
#  company    :string
#  country    :string
#  phone      :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lead < ApplicationRecord
end
