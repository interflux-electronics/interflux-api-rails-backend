module Admin
  class ProductTranslationSerializer < ApplicationSerializer
    attributes :pitch,
               :body

    belongs_to :product
    belongs_to :language
  end
end
