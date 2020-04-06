module V1
  module Admin
    class ArticleSerializer < ApplicationSerializer
      attributes :title,
                 :slug,
                 :body

      belongs_to :article_category
    end
  end
end
