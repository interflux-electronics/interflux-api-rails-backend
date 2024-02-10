# == Schema Information
#
# Table name: sessions
#
#  id                  :uuid             not null, primary key
#  browser_app         :string
#  browser_height      :string
#  browser_languages   :string
#  browser_width       :string
#  href                :string
#  ip                  :string
#  ip_isp              :string
#  ip_request_duration :integer
#  ip_response_body    :string
#  ip_response_code    :string
#  ip_timezone         :string
#  is_interflux_member :boolean          default(FALSE)
#  referrer            :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  ip_country_id       :string
#  user_id             :uuid
#
class Session < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :country, class_name: 'Country', foreign_key: 'ip_country_id', optional: true

  # after_create :fetch_country_from_ip

  # def fetch_country_from_ip
  #   AddIpMetaToSessionJob.perform_later(self, ip)
  # end

  # def ip
  #   request.remote_ip
  # end
end
