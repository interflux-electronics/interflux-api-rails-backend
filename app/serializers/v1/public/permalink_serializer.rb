module V1
  module Public
    class PermalinkSerializer < ApplicationSerializer
      attributes :slug,
                 :redirect_to
    end
  end
end
