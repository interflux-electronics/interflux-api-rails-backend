# == Schema Information
#
# Table name: translations
#
#  id             :uuid             not null, primary key
#  english        :string
#  english_before :text
#  error          :string
#  language       :string
#  location       :string
#  native         :string
#  status         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_translations_on_language      (language)
#  index_translations_on_location      (location)
#  unique_location_per_language_index  (language,location) UNIQUE
#
class Translation < ApplicationRecord
  validates :location, uniqueness: { scope: %i[language] }
  validates :status, inclusion: {
    in: %w[
      to-translate
      to-update
      to-review
      done
      error
    ]
  }
  validates :language, inclusion: {
    in: %w[
      en
      es
      de
      fr
      nl
      zh
    ]
  }

  # after_create :translate

  # def translate
  #   puts '------'
  #   puts 'after_create'
  #   puts "language: #{language}"
  #   puts "location: #{location}"
  #   puts "english: #{english}"
  #   puts '------'
  #   TranslateJob.perform_later(self) if native.nil?
  # end
end
