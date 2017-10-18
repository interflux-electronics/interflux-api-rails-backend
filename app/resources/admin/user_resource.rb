# frozen_string_literal: true

module Admin
  class UserResource < JSONAPI::Resource
    attributes :name,
               :email
  end
end
