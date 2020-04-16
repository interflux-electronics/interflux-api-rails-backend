# == Schema Information
#
# Table name: languages
#
#  id             :uuid             not null, primary key
#  name_english   :string
#  name_native    :string
#  two_letter_code :string
#  three_letter_code :string
#  public         :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

module V1
  module Public
    class LanguageSerializer < ApplicationSerializer
      attributes :name_english,
                 :name_native,
                 :two_letter_code
    end
  end
end
