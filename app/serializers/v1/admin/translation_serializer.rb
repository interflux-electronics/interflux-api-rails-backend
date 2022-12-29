module V1
  module Admin
    class TranslationSerializer < ApplicationSerializer
      attributes :key,
                 :language,
                 :native,
                 :english,
                 :needs_review,
                 :review_code,
                 :custom_review_message

      has_many :translation_events, if: requested?('translation_events')
    end
  end
end
