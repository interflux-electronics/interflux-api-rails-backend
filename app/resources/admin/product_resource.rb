# frozen_string_literal: true

module Admin
  class ProductResource < JSONAPI::Resource
    attributes :name,
               :slug,
               :corpus,
               :pitch,
               :product_type,
               :public
  end
end
