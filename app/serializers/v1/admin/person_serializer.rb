module V1
  module Admin
    class PersonSerializer < ApplicationSerializer
      attributes :first_name,
                 :last_name,
                 :chinese_name,
                 :email,
                 :phone,
                 :male
    end
  end
end
