module V1
  module Admin
    class DocumentCategorySerializer < ApplicationSerializer
      attributes :slug,
                 :name,
                 :name_single
    end
  end
end
