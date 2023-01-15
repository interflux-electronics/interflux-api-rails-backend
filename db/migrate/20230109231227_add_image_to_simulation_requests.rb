class AddImageToSimulationRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :simulation_requests, :image, :string
    add_column :simulation_requests, :sequence, :integer
  end
end
