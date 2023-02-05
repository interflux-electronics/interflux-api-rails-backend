module V1
  module Public
    class LeadsController < V1::PublicController
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
        Lead
      end

      def serializer_class
        V1::Public::LeadSerializer
      end

      def creatable_attributes
        %i[
          name
          company
          email
          mobile
          message
          purpose
          source
          ip
          ip_region
          ip_city
        ]
      end

      def creatable_relationships
        %i[
          country
          ip_country
        ]
      end
    end
  end
end
