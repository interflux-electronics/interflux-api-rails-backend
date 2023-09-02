class CreateSimulationRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :simulation_requests, id: :uuid do |t|
      t.string :project_name
      t.string :pallet_width
      t.string :pallet_height
      t.string :wave_speed
      t.string :cycle_time
      t.string :flux_brand
      t.string :flux_consumption
      t.string :board_reference
      t.string :known_issue
      t.string :solder_process
      t.string :flux_process
      t.string :full_name
      t.string :email
      t.string :company_name
    end
  end
end
