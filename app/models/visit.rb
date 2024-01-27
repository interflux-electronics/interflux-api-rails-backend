class Visit < ApplicationRecord
  belongs_to :user, optional: true
  # TODO: belongs_to :monthly_visitor_report

  # TODO: interpret the user agent
  def is_robot
    false
  end

  # TODO: interpret the user, IP and ISP
  def is_interflux
    false
  end
end
