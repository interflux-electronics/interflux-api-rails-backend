# frozen_string_literal: true

module Admin
  class ProductGroupResource < JSONAPI::Resource
    attributes :slug,
               :plural,
               :single
  end
end
