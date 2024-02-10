module V1
  module Admin
    class ServerSideRenderSerializer < ApplicationSerializer
      attributes :host,
                 :referrer,
                 :user_agent,
                 :ip,
                 :created_at
    end
  end
end
