module V1
  module Admin
    class PageViewSerializer < ApplicationSerializer
      attributes :path,
                 :created_at

      belongs_to :Visit
    end
  end
end
