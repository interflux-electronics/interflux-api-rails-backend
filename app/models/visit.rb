# == Schema Information
#
# Table name: visits
#
#  id                 :uuid             not null, primary key
#  first_seen         :datetime
#  host               :string
#  ip                 :string
#  ip_isp             :string
#  is_bot             :boolean
#  is_interflux       :boolean
#  last_seen          :datetime
#  path               :string
#  referrer           :string
#  user_agent         :string
#  viewport_height    :integer
#  viewport_width     :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  browser_session_id :uuid
#  ip_country_id      :string
#  user_id            :uuid
#
class Visit < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :ip_country, optional: true, class_name: 'Country'

  has_many :server_side_renders, dependent: :restrict_with_exception
  has_many :client_side_renders, dependent: :restrict_with_exception
  has_many :page_views, dependent: :restrict_with_exception
end
