module V1
  module Public
    class ImageSerializer < ApplicationSerializer
      attributes :cdn_path,
                 :sizes,
                 :formats,
                 :tag_long,
                 :tag_short
    end
  end
end
