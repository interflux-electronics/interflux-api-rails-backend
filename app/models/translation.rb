class Translation < ApplicationRecord
  has_many :translation_events, dependent: :destroy

  validates :review_code, inclusion: { in: [nil, 'untranslated', 'robot-translated', 'source-changed', 'custom'] }
end
