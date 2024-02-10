# == Schema Information
#
# Table name: simulation_requests
#
#  id               :uuid             not null, primary key
#  board_reference  :string
#  company_name     :string
#  cycle_time       :string
#  email            :string
#  flux_brand       :string
#  flux_consumption :string
#  flux_process     :string
#  full_name        :string
#  image            :string
#  known_issue      :string
#  pallet_length    :string
#  pallet_width     :string
#  project_name     :string
#  sequence         :integer
#  solder_process   :string
#  wave_speed       :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class SimulationRequest < ApplicationRecord
  after_create :send_email_to_singapore

  private

  def send_email_to_singapore
    update!(sequence: SimulationRequest.count + 1)

    SimulationRequestMailer.with(record: self).request_created.deliver_now
  end
end
