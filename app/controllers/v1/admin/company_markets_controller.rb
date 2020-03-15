module V1
  module Admin
    class CompanyMarketsController < ApplicationController
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
        CompanyMarket
      end

      def serializer_klass
        V1::Admin::CompanyMarketSerializer
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
        %[]
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
        %i[
          markets
          members
          members.person
        ]
      end

      # def after_create(lead)
      #   PostLeadToSlackJob.perform_later lead
      # end
    end
  end
end
