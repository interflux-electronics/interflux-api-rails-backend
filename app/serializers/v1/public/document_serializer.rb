module V1
  module Public
    class DocumentSerializer < ApplicationSerializer
      attributes :path,
                 :name

      belongs_to :document_category

      has_many :cdn_files, if: requested?('cdn_files')
    end
  end
end
