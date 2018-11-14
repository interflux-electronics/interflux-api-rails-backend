# Documentation:
# https://api.slack.com/docs/messages
# https://api.slack.com/docs/message-formatting
# https://api.slack.com/docs/message-attachments
# https://api.slack.com/docs/messages/builder
#
# Slack to @jan
# https://hooks.slack.com/services/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
#
# Slack to #website-leads
# https://hooks.slack.com/services/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
#
# Manual test:
# curl -X POST -H 'Content-type: application/json' --data '{"text":"Hello, World!"}' https://hooks.slack.com/services/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
#
class PostLeadToSlackJob < ApplicationJob
  require 'net/http'
  require 'uri'

  queue_as :default

  def perform(lead)
    @lead = lead
    url = URI('https://hooks.slack.com/services/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')
    data = {
      "username": 'Interflux Bot',
      "text": 'We received a new lead:',
      "unfurl_links": false,
      "unfurl_media": false,
      "attachments": [{
        'text': [
          "*#{attempt(lead.purpose)}*",
          "Message: #{attempt(lead.message)}\n",
          '*Sent by*',
          "Name: #{lead.name || '?'}",
          "Company: #{lead.company || '?'}",
          "Country: #{lead_country_name}",
          "Mobile: #{attempt(lead.mobile)}",
          "Email: #{attempt(lead.email)}\n",
          '*Sent from*',
          "IP: #{attempt(lead.ip)} (#{ip_country_name}, #{attempt(lead.ip_region)}, #{attempt(lead.ip_city)})",
          "URL: #{attempt(lead.source)}"
        ].join("\n"),
        "color": '#7CD197',
        "mrkdwn_in": ['text'],
        "ts": lead.created_at.to_time.to_i
      }]
    }.to_json
    headers = { 'Content-Type' => 'application/json' }

    res = Net::HTTP.post url, data, headers

    puts '---------'
    puts 'Response:'
    puts "Headers: #{res.to_hash.inspect}"
    puts res.code       # => '200'
    puts res.message    # => 'OK'
    puts res.class.name # => 'HTTPOK'
    puts '---------'
  end

  private

  def unknown
    '?'
  end

  def attempt(value)
    return unknown if value.blank?

    value
  end

  def lead_country_name
    return unknown if @lead.country.nil?

    @lead.country.name
  end

  def ip_country_name
    return unknown if @lead.ip_country.nil?

    @lead.ip_country.name
  end
end
