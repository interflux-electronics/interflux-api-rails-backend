class SimulationRequest < ApplicationRecord
  after_create :send_email_to_singapore

  private

  # create_table "simulation_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
  #   t.string "project_name"
  #   t.string "pallet_width"
  #   t.string "pallet_height"
  #   t.string "wave_speed"
  #   t.string "cycle_time"
  #   t.string "flux_brand"
  #   t.string "flux_consumption"
  #   t.string "board_reference"
  #   t.string "known_issue"
  #   t.string "solder_process"
  #   t.string "flux_process"
  #   t.string "full_name"
  #   t.string "email"
  #   t.string "company_name"
  # end

  def send_email_to_singapore
    puts '------'
    puts 'sending email to singapore'
    puts '------'

    SimulatioRequestMailer.request_created.deliver_later
  end
end
