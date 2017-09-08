# frozen_string_literal: true

module Public
  class ProductResource < JSONAPI::Resource
    attributes :name,
               :slug,
               :visible,
               :product_type,
               :pitch,
               :corpus
  end
end
