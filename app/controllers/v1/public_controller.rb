module V1
  class PublicController < ApplicationController
    before_action :create_visit

    private

    def create_visit
      id = request.headers['Visit-ID']

      return nil if id.nil?

      record = Visit.find_by(id: id)

      if record.nil?
        Visit.create!(
          id: id,
          start_time: DateTime.current,
          user_agent_ssr: request.headers['SSR-User-Agent']
        )
        log.debug '🌈 visit created'
      elsif !record.user_agent? || !request.browser_width
        Visit.update(
          user_agent: request.user_agent,
          browser_width: request.headers['Browser-Width'],
          browser_height: request.headers['Browser-Height']
        )
        log.debug '🌳 visit updated'
      else
        log.debug '❌ doing nothing'
      end
    end
  end
end
