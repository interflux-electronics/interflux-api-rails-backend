module V1
  module Public
    class FeatureSerializer < ApplicationSerializer
      attributes :slug,
                 :text,
                 :icon,
                 :gist
    end
  end
end
