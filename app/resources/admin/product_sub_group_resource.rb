# frozen_string_literal: true

module Admin
  class ProductSubGroupResource < JSONAPI::Resource
    attributes :slug,
               :plural,
               :single,
               :product_group_id
  end
end
