module V1
  module Public
    class ProductsController < ApplicationController
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
        Product
      end

      def serializer_klass
        V1::Public::ProductSerializer
      end

      def creatable_attributes
        %[]
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
        %[]
        # %i[
        #  country
        #  ip_country
        # ]
      end

      def permitted_filters
        %i[
          name
          deprecated
          popular
        ]
        # %i[
        #  main_group_id
        #  sub_group_id
        # ]
      end

      def permanent_filters
        {
          public: true
        }
      end

      def permitted_includes
        %i[
          product_family
          product_images
          product_images.image
          product_variants
          product_variants.container
        ]
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