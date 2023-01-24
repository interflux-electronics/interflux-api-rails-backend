class Translation < ApplicationRecord
  has_many :translation_events, dependent: :destroy

  validates :english, uniqueness: { scope: %i[language] }
  validates :review_code, inclusion: {
    in: [
      nil,
      'untranslated',
      'robot-translated',
      'source-changed',
      'custom'
    ]
  }

  after_create :translate

  def translate
    puts '------'
    puts 'after_create'
    puts "language: #{language}"
    puts "phrase: #{english}"
    puts '------'
    TranslateJob.perform_later(self) if native.nil?
  end
end
