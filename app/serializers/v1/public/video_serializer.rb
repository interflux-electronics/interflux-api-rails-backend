module V1
  module Public
    class VideoSerializer < ApplicationSerializer
      attributes :path,
                 :variations,
                 :title
    end
  end
end
