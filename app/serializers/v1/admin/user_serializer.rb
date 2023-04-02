module V1
  module Admin
    class UserSerializer < ApplicationSerializer
      attributes :email,
                 :abilities

      belongs_to :person
    end
  end
end
