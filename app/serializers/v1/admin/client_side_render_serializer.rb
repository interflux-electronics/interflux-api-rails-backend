module V1
  module Admin
    class ClientSideRenderSerializer < ApplicationSerializer
      attributes :host,
                 :path,
                 :referrer,
                 :user_agent,
                 :ip,
                 :viewport_width,
                 :viewport_height,
                 :created_at,
                 :browser_session_id

      belongs_to :server_side_render
      belongs_to :user
      belongs_to :visit
    end
  end
end
