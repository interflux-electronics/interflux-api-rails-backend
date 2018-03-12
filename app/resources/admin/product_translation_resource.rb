module Admin
  class ProductTranslationResource < JSONAPI::Resource
    attributes :pitch,
               :body

    relationship :product, to: :one
    relationship :language, to: :one
  end
end
