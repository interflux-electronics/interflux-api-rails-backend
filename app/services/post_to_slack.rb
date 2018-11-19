#
# This service aims to abstract all functionalities that have to do with sending
# and receiving data to and from Slack.
#
# Documentation
# https://api.slack.com/incoming-webhooks
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
class PostToSlack
  require 'net/http'

  def initialize(channel, data)
    @channel = channel
    @data = data
  end

  def call
    post_message_to_channel
  end

  private

  attr_reader :channel, :data

  def post_message_to_channel
    response = Net::HTTP.post uri, data, headers

    print(response) if Rails.env == 'development'
  end

  def uri
    URI(url)
  end

  def url
    return leads_channel_url if channel == '#website-leads' && Rails.env == 'production'

    dm_jan_url
  end

  def leads_channel_url
    'https://hooks.slack.com/services/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'
  end

  def dm_jan_url
    'https://hooks.slack.com/services/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'
  end

  def headers
    { 'Content-Type' => 'application/json' }
  end

  def print(response)
    puts '---------'
    puts 'Slack HTTP response:'
    puts "Headers: #{response.to_hash.inspect}"
    puts response.code
    puts response.message
    puts response.class.name
    puts '---------'
  end
end
