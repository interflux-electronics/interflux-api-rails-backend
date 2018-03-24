module Admin
  class UserSerializer < ApplicationSerializer
    attributes :name,
               :email
  end
end
