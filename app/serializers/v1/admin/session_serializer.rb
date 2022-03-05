module V1
  module Admin
    class SessionSerializer < ApplicationSerializer
      attributes :href,
                 :referrer,
                 :ip,
                 :ip_country_id,
                 :ip_timezone,
                 :ip_isp,
                 :browser_app,
                 :browser_width,
                 :browser_height,
                 :browser_languages,
                 :is_interflux_member

      belongs_to :user
      belongs_to :country
    end
  end
end
