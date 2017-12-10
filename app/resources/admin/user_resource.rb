

module Admin
  class UserResource < JSONAPI::Resource
    attributes :name,
               :email
  end
end
