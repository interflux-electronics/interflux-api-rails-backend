#
# This job is responsible for translating records with Deepl Pro
#
class TranslateJob < ApplicationJob
  queue_as :default

  def perform(record)
    puts '======'
    puts 'translate_job start'
    phrase = record.english
    source_lang = 'EN'
    target_lang = record.language.upcase
    translation = TranslateService.new(phrase, source_lang, target_lang).call
    puts '======'
    puts translation
    puts '======'
    record.update!(native: translation) unless translation.nil?
    puts 'translate_job end'
    puts '======'
  end
end
