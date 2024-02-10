# == Schema Information
#
# Table name: events
#
#  id          :uuid             not null, primary key
#  city        :string
#  dates       :string
#  description :string
#  end_date    :string
#  name        :string
#  start_date  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  country_id  :string
#
class Event < ApplicationRecord
  belongs_to :country
end
