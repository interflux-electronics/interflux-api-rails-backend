#
# This job is responsible for posting new leads in Slack.
#
class PostLeadToSlackJob < ApplicationJob
  queue_as :default

  def perform(lead)
    @lead = lead
    PostToSlack.new('#website-leads', data).call
  end

  private

  attr_reader :lead

  def data
    {
      "username": 'Interflux Bot',
      "text": 'Humans, someone just requested an *LMPA demo*. Please follow up.',
      "unfurl_links": false,
      "unfurl_media": false,
      "attachments": [{
        'text': [
          '*Message*',
          "#{attempt(lead.message)}\n",
          '*Sent by*',
          "Name: #{lead.name || '?'}",
          "Company: #{lead.company || '?'}",
          "Country: #{lead_country_name}",
          "Mobile: #{attempt(lead.mobile)}",
          "Email: #{attempt(lead.email)}\n",
          '*Sent from*',
          "IP: #{attempt(lead.ip)} (#{attempt(lead.ip_city)}, #{attempt(lead.ip_region)}, #{ip_country_name})",
          "URL: #{attempt(lead.source)}"
        ].join("\n"),
        "color": '#7CD197',
        "mrkdwn_in": ['text'],
        "ts": lead.created_at.to_time.to_i
      }]
    }.to_json
  end

  def attempt(value)
    return '?' if value.blank?

    value
  end

  def lead_country_name
    return '?' if lead.country.nil?

    lead.country.name
  end

  def ip_country_name
    return '?' if lead.ip_country.nil?

    lead.ip_country.name
  end
end
