module V1
  module Public
    class CdnFileSerializer < ApplicationSerializer
      attributes :path

      belongs_to :document
      belongs_to :image
    end
  end
end
