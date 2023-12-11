module V1
  module Admin
    class VideoSerializer < ApplicationSerializer
      attributes :path,
                 :variations,
                 :title,
                 :notes
    end
  end
end
