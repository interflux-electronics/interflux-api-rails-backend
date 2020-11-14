# == Schema Information
#
# Table name: people
#
#  id           :uuid             not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  first_name   :string
#  last_name    :string
#  chinese_name :string
#  email        :string
#  phone        :string
#  male         :boolean
#

class Person < ApplicationRecord
  has_one :user
end
