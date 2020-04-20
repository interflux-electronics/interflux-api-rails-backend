module V1
  module Public
    class FeatureSerializer < ApplicationSerializer
      attributes :slug,
                 :text,
                 :icon,
                 :gist,
                 :category
    end
  end
end
