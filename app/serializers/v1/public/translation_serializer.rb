module V1
  module Public
    class TranslationSerializer < ApplicationSerializer
      attributes :key,
                 :language,
                 :native
    end
  end
end
