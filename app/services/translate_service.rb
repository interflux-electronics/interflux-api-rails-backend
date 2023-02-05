#
# This service hits the Deepl Pro API with an phrase phrase
# and will translate it to the chosen output target_lang.
#
# A simple exampl:
# curl -X POST 'https://api.deepl.com/v2/translate' \
# 	-H 'Authorization: DeepL-Auth-Key THE_API_KEY' \
# 	-d 'text=Hello%2C%20world!' \
# 	-d 'target_lang=DE'
#
# Documentation
# https://www.deepl.com/docs-api
#

class TranslateService
  require 'faraday'
  require 'uri'

  def initialize(phrase, source_lang, target_lang)
    @phrase = phrase
    @source_lang = source_lang
    @target_lang = target_lang
  end

  def call
    translation
  end

  private

  attr_reader :phrase, :source_lang, :target_lang

  def translation
    puts '---'
    puts 'translating...'
    puts '---'
    puts "phrase: #{@phrase}"
    puts "target_lang: #{@target_lang}"
    puts "source_lang: #{@source_lang}"
    puts '---'

    return puts 'FAIL: no phrase' if @phrase.nil?
    return puts 'FAIL: target_lang not supported' unless supported_languages.include?(@target_lang.to_sym)
    return puts 'FAIL: source_lang not supported' unless supported_languages.include?(@source_lang.to_sym)

    {
      success: true,
      translations: ['Ich bin foo bar', 'Meine Name is foo bar', 'Ich heise foo bar']
    }

    # response = Faraday.post(url) do |req|
    #   req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
    #   req.headers['Authorization'] = "DeepL-Auth-Key #{api_key}"
    #   req.body = URI.encode_www_form(data)
    # end

    # return puts 'FAIL: request failed' unless response.status == 200

    # body = JSON.parse(response.body)

    # return puts 'FAIL: no translations key' unless body.key?('translations')

    # translations = body['translations']

    # return puts 'FAIL: no translations' if translations.empty?

    # translation = translations.first['text']

    # puts "translations: #{translation}"
    # puts '---'

    # translation
  end

  def url
    'https://api.deepl.com/v2/translate'
  end

  def data
    {
      text: @phrase,
      target_lang: @target_lang,
      source_lang: @source_lang
    }
  end

  def api_key
    ENV.fetch('DEEPL_PRO_API_KEY')
  end

  def supported_languages
    %i[
      BG
      CS
      DA
      DE
      EL
      EN
      EN-GB
      EN-US
      ES
      ET
      FI
      FR
      HU
      ID
      IT
      JA
      LT
      LV
      NL
      PL
      PT
      PT-BR
      PT-PT
      RO
      RU
      SK
      SL
      SV
      TR
      UK
      ZH
    ]
  end
end
