module V1
  module Public
    class ImageSerializer < ApplicationSerializer
      attributes :path,
                 :sizes,
                 :formats,
                 :alt,
                 :caption
    end
  end
end
