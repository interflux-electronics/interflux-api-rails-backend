module V1
  module Public
    class SimulationRequestSerializer < ApplicationSerializer
      attributes :project_name,
                 :pallet_width,
                 :pallet_length,
                 :wave_speed,
                 :cycle_time,
                 :flux_brand,
                 :flux_consumption,
                 :board_reference,
                 :known_issue,
                 :solder_process,
                 :flux_process,
                 :full_name,
                 :email,
                 :company_name,
                 :image,
                 :sequence
    end
  end
end
