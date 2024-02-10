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
class Visit < ApplicationRecord
  belongs_to :user, optional: true

  has_one :server_side_render, optional: true, dependent: nil
  has_one :client_side_render, optional: true, dependent: nil

  has_many :page_view, dependent: :restrict_with_exception
end
