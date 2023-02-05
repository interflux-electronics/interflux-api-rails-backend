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
