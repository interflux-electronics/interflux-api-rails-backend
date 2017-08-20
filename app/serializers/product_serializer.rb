# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :slug,
             :pitch,
             :corpus,
             :image_url,
             :product_type
end
