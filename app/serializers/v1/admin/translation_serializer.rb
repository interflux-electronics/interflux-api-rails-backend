module V1
  module Admin
    class TranslationSerializer < ApplicationSerializer
      attributes :location,
                 :language,
                 :native,
                 :english,
                 :english_before,
                 :status,
                 :error
    end
  end
end
