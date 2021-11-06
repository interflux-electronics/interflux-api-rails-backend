module V1
  module Admin
    class CdnFileSerializer < ApplicationSerializer
      attributes :path

      belongs_to :image
      belongs_to :video
      belongs_to :document
    end
  end
end
