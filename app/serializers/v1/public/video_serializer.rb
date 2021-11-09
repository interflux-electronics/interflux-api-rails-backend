module V1
  module Public
    class VideoSerializer < ApplicationSerializer
      attributes :path,
                 :variations,
                 :title_public,
                 :title_admin,
                 :poster_url
    end
  end
end
