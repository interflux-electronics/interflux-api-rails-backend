module V1
  module Public
    class ProductFeaturesController < ApplicationController
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
        ProductFeature
      end

      def serializer_klass
        V1::Public::ProductFeatureSerializer
      end

      def creatable_attributes
        %i[]
        # %i[
        #   name
        #   company
        #   email
        #   mobile
        #   message
        #   purpose
        #   source
        #   ip
        #   ip_region
        #   ip_city
        # ]
      end

      def creatable_relationships
        %i[]
        # %i[
        #  country
        #  ip_country
        # ]
      end

      def permitted_filters
        %i[]
        # %i[
        #  main_group_id
        #  sub_group_id
        # ]
      end

      def permanent_filters
        {}
        # {
        #   public: true
        # }
      end

      def permitted_includes
        %i[]
        # %i[
        #   related_articles
        #   related_products
        #   related_products.main_group
        #   translations
        # ]
      end

      # def after_create(lead)
      #   PostLeadToSlackJob.perform_later lead
      # end
    end
  end
end
