module V1
  module Public
    class DocumentCategorySerializer < ApplicationSerializer
      attributes :slug,
                 :name,
                 :gist,
                 :icon,
                 :order

      has_many :documents, if: requested?('documents')
      has_many :cdn_files, if: requested?('cdn_files')
    end
  end
end
