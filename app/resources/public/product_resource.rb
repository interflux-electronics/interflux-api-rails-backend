module Public
  class ProductResource < JSONAPI::Resource
    attributes :name,
               :slug,
               :body,
               :pitch,
               :product_type,
               :public

    has_many :documents
    has_many :product_translations
  end
end
