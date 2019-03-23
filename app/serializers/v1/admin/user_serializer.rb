module V1
  module Admin
    class UserSerializer < ApplicationSerializer
      attributes :email

      belongs_to :person
    end
  end
end
