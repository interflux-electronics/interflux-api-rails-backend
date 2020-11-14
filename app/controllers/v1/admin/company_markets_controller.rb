module V1
  module Admin
    class CompanyMarketsController < V1::AdminController
      def index
        allow_index
      end

      def show
        allow_show
      end

      def create
        allow_create
      end

      def update
        allow_update
      end

      def destroy
        allow_destroy
      end

      private

      def model_class
        CompanyMarket
      end

      def serializer_class
        V1::Admin::CompanyMarketSerializer
      end

      def creatable_relationships
        %i[
          company
          country
        ]
      end
    end
  end
end
