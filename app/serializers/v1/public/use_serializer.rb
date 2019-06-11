module V1
  module Public
    class UseSerializer < ApplicationSerializer
      attributes :slug,
                 :name
    end
  end
end
