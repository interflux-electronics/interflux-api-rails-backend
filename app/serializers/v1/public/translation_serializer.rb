module V1
  module Public
    class TranslationSerializer < ApplicationSerializer
      attributes :key,
                 :locale,
                 :native
    end
  end
end
