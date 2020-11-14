module V1
  module Admin
    class CountriesController < V1::AdminController
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
        Country
      end

      def serializer_class
        V1::Admin::CountrySerializer
      end

      def permitted_filters
        %i[
          name_english
        ]
      end
    end
  end
end
