module V1
  module Admin
    class PersonImageSerializer < ApplicationSerializer
      belongs_to :person
      belongs_to :image
    end
  end
end
