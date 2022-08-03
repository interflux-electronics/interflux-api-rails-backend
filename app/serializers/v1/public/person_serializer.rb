module V1
  module Public
    class PersonSerializer < ApplicationSerializer
      attributes :first_name,
                 :last_name,
                 :chinese_name,
                 :full_name,
                 :avatar_path,
                 :avatar_variations,
                 :avatar_caption,
                 :avatar_alt
    end
  end
end
