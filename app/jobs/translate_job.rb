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
    response = TranslateService.new(phrase, source_lang, target_lang).call
    return puts 'FAIL' unless response[:success]

    puts '======'
    puts response
    puts '======'
    first_translation = response[:translations].first
    record.update!(native: first_translation)
    puts 'translate_job end'
    puts '======'
  end
end
