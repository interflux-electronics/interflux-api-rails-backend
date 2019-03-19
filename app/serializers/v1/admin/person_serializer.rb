module V1
  module Admin
    class PersonSerializer < ApplicationSerializer
      attributes :first_name,
                 :last_name
    end
  end
end
