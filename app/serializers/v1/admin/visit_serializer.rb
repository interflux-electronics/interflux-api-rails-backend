module V1
  module Admin
    class VisitSerializer < ApplicationSerializer
      attributes :host,
                 :referrer,
                 :user_agent,
                 :ip,
                 :ip_isp,
                 :viewport_width,
                 :viewport_height,
                 :is_interflux,
                 :is_bot,
                 :first_seen,
                 :last_seen,
                 :browser_session_id

      belongs_to :user
      belongs_to :ip_country, record_type: :country, serializer: :country

      has_many :server_side_renders
      has_many :client_side_renders
      has_many :page_views
    end
  end
end
