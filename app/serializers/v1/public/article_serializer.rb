module V1
  module Public
    class ArticleSerializer < ApplicationSerializer
      include FastJsonapi::ObjectSerializer

      attributes :slug,
                 :title,
                 :tease

      belongs_to :author
    end
  end
end
