module V1
  module Admin
    class PermalinkSerializer < ApplicationSerializer
      attributes :slug,
                 :redirect_to,
                 :notes

      belongs_to :event
    end
  end
end
