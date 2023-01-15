#
# This job is responsible for translating records with Deepl Pro
#
class TranslateJob < ApplicationJob
  queue_as :low_priority

  def perform(record)
    puts '------'
    puts 'translate_job start'
    translation = TranslateService.new(english, language).call
    puts '------'
    puts translation
    puts '------'
    record.update!(native: translation) unless translation.nil?
    puts 'translate_job end'
    puts '------'
  end
end
