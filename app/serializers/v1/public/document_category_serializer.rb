module V1
  module Public
    class DocumentCategorySerializer < ApplicationSerializer
      attributes :slug,
                 :name
    end
  end
end
