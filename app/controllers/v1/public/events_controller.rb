module V1
  module Public
    class EventsController < V1::PublicController
      def index
        allow_index
      end

      def show
        allow_show
      end

      def create
        forbidden
      end

      def update
        forbidden
      end

      def destroy
        forbidden
      end

      private

      def model_class
        Event
      end

      def serializer_class
        V1::Public::EventSerializer
      end

      def permitted_includes
        %i[
          country
        ]
      end
    end
  end
end
