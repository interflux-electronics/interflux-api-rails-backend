module V1
  module Public
    class TranslationSerializer < ApplicationSerializer
      attributes :location,
                 :language,
                 :native,
                 :english
    end
  end
end
