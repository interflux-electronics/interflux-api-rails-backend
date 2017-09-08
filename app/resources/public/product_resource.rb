# frozen_string_literal: true

module Public
  class ProductResource < JSONAPI::Resource
    attributes :name,
               :slug,
               :public,
               :product_type,
               :pitch,
               :corpus
  end
end
