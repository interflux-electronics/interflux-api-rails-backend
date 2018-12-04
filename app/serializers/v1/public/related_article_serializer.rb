module V1
  module Public
    class RelatedArticleSerializer < ApplicationSerializer
      include FastJsonapi::ObjectSerializer

      set_type :article

      attributes :slug,
                 :title,
                 :tease
    end
  end
end
