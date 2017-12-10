module Admin
  class ProductTranslationResource < JSONAPI::Resource
    attributes :product_id,
               :locale,
               :name,
               :pitch,
               :body
  end
end
