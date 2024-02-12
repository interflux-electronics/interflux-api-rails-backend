namespace :visits do
  task process: :environment do
    log.info 'visits:process ⛵️'

    # For reference:
    # ClientSideRender.joins(:visit)
    # ClientSideRender.where.missing(:visit)
    # ... are opposites.

    browser_sessions = ClientSideRender.where.missing(:visit).pluck(:browser_session_id).uniq

    browser_sessions.each do |browser_session|
      csrs = ClientSideRender.where(browser_session_id: browser_session).order('created_at ASC')

      # The host, user agent and IP should be unique across the entire browser session.

      hosts = csrs.pluck(:host).uniq
      user_agents = csrs.pluck(:user_agent).uniq
      ips = csrs.pluck(:ip).uniq

      if hosts.count != 1
        log.warn "❌ 1 | #{browser_session}"
        next
      end

      if user_agents.count != 1
        log.warn "❌ 2 | #{browser_session}"
        next
      end

      if ips.count != 1
        log.warn "❌ 3 | #{browser_session}"
        next
      end

      record = Visit.create(
        browser_session_id: browser_session,

        host: hosts.first,
        path: csrs.first.path,
        referrer: csrs.first.referrer,
        user_agent: user_agents.first,

        ip: ips.first,
        # ip_isp: nil, # TODO
        # ip_country_id: nil, # TODO

        viewport_width: csrs.first.viewport_width,
        viewport_height: csrs.first.viewport_height,

        # is_interflux: false, # TODO
        # is_bot: false, # TODO

        first_seen: csrs.first.created_at
        # last_seen: nil # TODO
        # user_id: nil # TODO
      )

      log.info "✅ created Visit #{record.id}"

      csrs.each do |csr|
        csr.update(visit: record)

        ssr = csr.server_side_render

        if ssr.nil?
          log.warn '❌ no SSR'
          log.warn csr.id
          next
        end

        ssr.update(visit: record)

        log.info '✅ - updated CSR and SSR'

        if csr.path != ssr.path
          log.warn '❌ path not identical'
          log.warn csr.id
          log.warn csr.path
          log.warn ssr.path
        end

        if csr.host != ssr.host
          log.warn '❌ host not identical'
          log.warn csr.id
          log.warn csr.host
          log.warn ssr.host
        end

        if csr.referrer != ssr.referrer
          log.warn '❌ referrer not identical'
          log.warn csr.id
          log.warn csr.referrer
          log.warn ssr.referrer
        end

        if csr.user_agent != ssr.user_agent
          log.warn '❌ UA not identical'
          log.warn csr.id
          log.warn csr.user_agent
          log.warn ssr.user_agent
        end

        next unless csr.ip != ssr.ip

        log.warn '❌ IP not identical'
        log.warn csr.id
        log.warn csr.ip
        log.warn ssr.ip
      end
    end

    log.info 'visits:process ✅'
  end

  def log
    Rails.logger
  end
end
