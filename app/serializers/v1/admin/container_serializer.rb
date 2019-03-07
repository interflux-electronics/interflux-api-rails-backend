module V1
  module Admin
    class ContainerSerializer < ApplicationSerializer
      attributes :name,
                 :created_at,
                 :updated_at
    end
  end
end
