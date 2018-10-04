# == Schema Information
#
# Table name: languages
#
#  id           :uuid             not null, primary key
#  locale       :string
#  name_english :string
#  name_native  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class LanguageSerializer < ApplicationSerializer
  attributes :locale,
             :name_english,
             :name_native
end
