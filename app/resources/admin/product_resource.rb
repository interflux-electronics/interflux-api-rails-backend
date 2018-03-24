# module Admin
#   class ProductResource < JSONAPI::Resource
#     attributes :name,
#                :slug,
#                :pitch,
#                :body,
#                :public
#
#     relationship :main_category, class_name: 'ProductCategory', foreign_key: 'main_category_id', to: :one
#     relationship :sub_category, class_name: 'ProductCategory', foreign_key: 'sub_category_id', to: :one
#   end
# end
