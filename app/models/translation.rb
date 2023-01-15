class Translation < ApplicationRecord
  has_many :translation_events, dependent: :destroy

  validates :key, uniqueness: { scope: :language }
  validates :review_code, inclusion: { in: [nil, 'untranslated', 'robot-translated', 'source-changed', 'custom'] }

  after_create :translate

  def translate
    puts '------'
    puts 'after_create'
    puts language
    puts english
    TranslateJob.perform_later(self)
  end
end
