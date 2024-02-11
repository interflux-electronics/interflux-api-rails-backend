module V1
  module Admin
    class ServerSideRenderSerializer < ApplicationSerializer
      attributes :host,
                 :path,
                 :referrer,
                 :user_agent,
                 :ip,
                 :created_at

      belongs_to :visit
    end
  end
end
