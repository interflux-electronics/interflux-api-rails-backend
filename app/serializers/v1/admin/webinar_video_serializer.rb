module V1
  module Admin
    class WebinarVideoSerializer < ApplicationSerializer
      belongs_to :webinar
      belongs_to :video
    end
  end
end
