module V1
  module Admin
    class CdnFileSerializer < ApplicationSerializer
      attributes :path

      belongs_to :document
      belongs_to :image
    end
  end
end
