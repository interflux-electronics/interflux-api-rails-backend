module V1
  module Public
    class PersonSerializer < ApplicationSerializer
      include FastJsonapi::ObjectSerializer

      attributes :first_name,
                 :last_name
    end
  end
end
