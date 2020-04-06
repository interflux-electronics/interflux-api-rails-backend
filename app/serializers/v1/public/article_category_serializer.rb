module V1
  module Public
    class ArticleCategorySerializer < ApplicationSerializer
      attributes :name,
                 :slug
    end
  end
end
