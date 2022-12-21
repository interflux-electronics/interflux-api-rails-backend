module V1
  module Admin
    class TranslationEventSerializer < ApplicationSerializer
      attributes :code,
                 :updated_by,
                 :created_at

      belongs_to :translation
    end
  end
end
