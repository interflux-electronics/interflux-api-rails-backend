module V1
  module Public
    class SimulationRequestsController < ApplicationController
      def index
        forbidden
      end

      def show
        forbidden
      end

      def create
        allow_create
      end

      def update
        forbidden
      end

      def destroy
        forbidden
      end

      private

      def model_class
        SimulationRequest
      end

      def serializer_class
        V1::Public::SimulationRequestSerializer
      end

      def creatable_attributes
        %i[
          project_name
          pallet_width
          pallet_height
          wave_speed
          cycle_time
          flux_brand
          flux_consumption
          board_reference
          known_issue
          solder_process
          flux_process
          full_name
          email
          company_name
        ]
      end
    end
  end
end
