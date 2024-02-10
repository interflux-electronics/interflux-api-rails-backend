module V1
  module Admin
    class VisitSerializer < ApplicationSerializer
      attributes :host,
                 :referrer,
                 :user_agent,
                 :ip,
                 :ip_isp,
                 :ip,
                 :viewport_width,
                 :viewport_height,
                 :is_interflux,
                 :is_bot,
                 :created_at

      belongs_to :server_side_render
      belongs_to :client_side_render
      belongs_to :user
      belongs_to :country

      has_many :page_views
    end
  end
end
