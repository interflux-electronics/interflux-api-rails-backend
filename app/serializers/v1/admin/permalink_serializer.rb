module V1
  module Admin
    class PermalinkSerializer < ApplicationSerializer
      attributes :slug,
                 :redirect_to,
                 :notes
    end
  end
end
