module Admin
  class ProductTranslationResource < JSONAPI::Resource
    attributes :product_id,
               :language_id,
               :pitch,
               :body
  end
end
