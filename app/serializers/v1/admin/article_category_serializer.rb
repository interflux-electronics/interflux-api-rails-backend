module V1
  module Admin
    class ArticleCategorySerializer < ApplicationSerializer
      attributes :name,
                 :slug
    end
  end
end
