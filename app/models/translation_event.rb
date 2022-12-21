class TranslationEvent < ApplicationRecord
  belongs_to :translation

  validates :code, inclusion: { in: %w[created human-update robot-update source-update] }
end
