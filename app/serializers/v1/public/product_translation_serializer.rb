module V1
  module Public
    class ProductTranslationSerializer < ApplicationSerializer
      include FastJsonapi::ObjectSerializer

      attributes :slug,
                 :name,
                 :pitch

      belongs_to :product
      belongs_to :language
    end
  end
end
