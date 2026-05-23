module V1
  module Public
    class EventsController < V1::PublicController
      def index
        @records = Event.upcoming if params['upcoming'] == 'true'
        @records = Event.past if params['past'] == 'true'

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

      def permitted_filters
        %i[
          upcoming
          past
        ]
      end
    end
  end
end
