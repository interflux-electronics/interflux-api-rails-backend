# frozen_string_literal: true

module Admin
  class ProductTranslationResource < JSONAPI::Resource
    attributes :product_id,
               :locale,
               :name,
               :pitch,
               :corpus
  end
end
