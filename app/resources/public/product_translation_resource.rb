# frozen_string_literal: true

module Public
  class ProductTranslationResource < JSONAPI::Resource
    attributes :product_id,
               :locale,
               :name,
               :pitch,
               :body
  end
end
