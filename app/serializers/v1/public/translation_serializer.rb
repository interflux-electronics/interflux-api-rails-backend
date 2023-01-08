module V1
  module Public
    class TranslationSerializer < ApplicationSerializer
      attributes :key,
                 :language,
                 :native,
                 :english
    end
  end
end
