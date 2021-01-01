module V1
  module Admin
    class UseImageSerializer < ApplicationSerializer
      belongs_to :use
      belongs_to :image
    end
  end
end
