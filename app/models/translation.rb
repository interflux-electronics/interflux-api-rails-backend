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
