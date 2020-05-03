module V1
  module Public
    class DocumentCategorySerializer < ApplicationSerializer
      attributes :slug,
                 :name,
                 :gist,
                 :icon,
                 :order
    end
  end
end
