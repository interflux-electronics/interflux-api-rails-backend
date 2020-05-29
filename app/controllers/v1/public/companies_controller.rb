module V1
  module Public
    class CompaniesController < ApplicationController
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

      def resource_klass
        Company
      end

      def serializer_klass
        V1::Public::CompanySerializer
      end

      def permanent_filters
        {
          public: true
        }
      end
    end
  end
end
