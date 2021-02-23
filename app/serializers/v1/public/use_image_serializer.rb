module V1
  module Public
    class UseImageSerializer < ApplicationSerializer
      attributes :rank_among_uses,
                 :rank_among_images

      belongs_to :use
      belongs_to :image
    end
  end
end
