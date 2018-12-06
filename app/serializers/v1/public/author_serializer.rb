module V1
  module Public
    class AuthorSerializer < ApplicationSerializer
      include FastJsonapi::ObjectSerializer

      attributes :tagline

      belongs_to :person
      has_many :articles
    end
  end
end
