class TranslationEvent < ApplicationRecord
  belongs_to :translation

  validates :code, inclusion: { in: %w[
    missing-translation
    record-created
    robot-translated
    human-approved
    human-translated
    english-source-changed
  ] }
end
