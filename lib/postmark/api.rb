module Postmark
  class Api
    def initialize(server_token: nil, account_token: nil)
      @server_token = server_token
      @account_token = account_token
    end

    def list_templates
      done = false # keep fetching until true
      size = 100 # how many records to fetch per request
      offset = 0 # where the next record should start
      count = 1 # request count
      results = [] # all the templates fetched

      until done
        response = api.get('/templates') do |req|
          req.params = {
            count: size,
            offset: offset
          }.compact
        end

        raise "#{response.status} #{JSON.parse(response.body)}" if response.status != 200

        first = ((count - 1) * size) + 1
        last = count * size
        log.info "✅ request #{first}-#{last}"

        body = JSON.parse(response.body)
        results.push body['Templates']
        offset = count * size
        done = offset > body['TotalCount']
        count += 1
      end

      # We have an array of arrays at this point.
      # First flatten, then return.
      results.flatten
    end

    # Send email with template
    # https://postmarkapp.com/developer/api/templates-api
    def send_email_with_template(
      template_model:,
      from:,
      to:,
      template_id: nil,
      template_alias: nil,
      inline_css: nil,
      cc: nil,
      bcc: nil,
      tag: nil,
      reply_to: nil,
      headers: nil,
      track_opens: nil,
      track_links: nil,
      attachments: nil,
      metadata: nil,
      message_stream: nil
    )
      # Either the template ID or alias should be passed in
      # Prefer aliases for readability.
      # Though IDs cannot change over time, aliases can.
      raise '🔥 no template' if template_id.nil? && template_alias.nil?

      body = {
        TemplateId: template_id,
        TemplateAlias: template_alias,
        TemplateModel: template_model,
        InlineCss: inline_css,
        From: from,
        To: to,
        Cc: cc,
        Bcc: bcc,
        Tag: tag,
        ReplyTo: reply_to,
        Headers: headers,
        TrackOpens: track_opens,
        TrackLinks: track_links,
        Attachments: attachments,
        Metadata: metadata,
        MessageStream: message_stream
      }.compact.to_json

      api.post('/email/withTemplate/') do |req|
        req.body = body
      end
    end

    private

    def api
      Faraday.new(
        url: 'https://api.postmarkapp.com',
        headers: {
          'Content-Type': 'application/json',
          Accept: 'application/json',
          'X-Postmark-Server-Token': @server_token,
          'User-Agent': 'Jan Werkhoven (jw@interflux.au)'
        }
      ) do |f|
        f.request :url_encoded
        f.request :curl, log, :info
        f.adapter Faraday.default_adapter
      end
    end

    # All endpoints return in the same way.
    # Raise unless status is 200.
    # Parse JSON data if present.
    # Otherwise return nil.
    # def data
    #   if @response.status != 200
    #     ap @body
    #     ap @response
    #     raise "🔥 #{@response.status} #{@response.body}"
    #   end

    #   return JSON.parse(@response.body) if @response.body.present?

    #   nil
    # end

    def log
      Rails.logger
    end
  end
end
