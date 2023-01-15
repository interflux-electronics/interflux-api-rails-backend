#
# This service hits the Deepl Pro API with an English phrase
# and will translate it to the chosen output language.
#
# A simple exampl:
# curl -X POST 'https://api.deepl.com/v2/translate' \
# 	-H 'Authorization: DeepL-Auth-Key 586e95e8-cd73-23ae-dae9-42fb2abc4eed' \
# 	-d 'text=Hello%2C%20world!' \
# 	-d 'target_lang=DE'
#
# Documentation
# https://www.deepl.com/docs-api
#
class TranslateService
  require 'net/http'

  def initialize(english, language)
    @english = english
    @language = language
  end

  def call
    translation
  end

  private

  attr_reader :english, :language

  def translation
    response = Net::HTTP.post uri, data, headers

    log(response) if Rails.env.development?

    response
  end

  def uri
    URI('url')
  end

  def url
    'https://api.deepl.com/v2/translate'
  end

  def data
    { 'text' => @english, 'target_lang' => @language }.to_json
  end

  def headers
    { 'Authorization' => "DeepL-Auth-Key #{api_key}" }
  end

  def api_key
    ENV.fetch('DEEPL_PRO_API_KEY')
  end

  def log(response)
    puts '---------'
    puts 'Deepl Translator response:'
    puts response.to_hash.inspect.to_s
    puts '---------'
  end
end
