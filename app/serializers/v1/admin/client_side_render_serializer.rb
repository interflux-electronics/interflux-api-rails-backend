module V1
  module Admin
    class ClientSideRenderSerializer < ApplicationSerializer
      attributes :host,
                 :referrer,
                 :user_agent,
                 :ip,
                 :viewport_width,
                 :viewport_height,
                 :created_at

      belongs_to :server_side_render
      belongs_to :user
    end
  end
end
