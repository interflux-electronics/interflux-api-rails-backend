module Admin
  class ProductSerializer
    include FastJsonapi::ObjectSerializer
    set_type :product
    attributes :name, :slug, :pitch, :body, :public
    belongs_to :main_category, record_type: :product_category
    belongs_to :sub_category, record_type: :product_category
  end
end
