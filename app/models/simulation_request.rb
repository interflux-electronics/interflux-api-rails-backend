class SimulationRequest < ApplicationRecord
  after_create :send_email_to_singapore

  private

  def send_email_to_singapore
    update!(sequence: SimulationRequest.count + 1)

    SimulationRequestMailer.with(record: self).request_created.deliver_now
  end
end
