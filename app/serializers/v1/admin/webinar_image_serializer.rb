module V1
  module Admin
    class WebinarImageSerializer < ApplicationSerializer
      belongs_to :webinar
      belongs_to :image
    end
  end
end
