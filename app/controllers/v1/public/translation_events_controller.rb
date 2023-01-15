module V1
  module Public
    class TranslationEventsController < ApplicationController
      def index
        forbidden
      end

      def show
        forbidden
      end

      def create
        props = OpenStruct.new(
          key: params['key'],
          language: params['language'],
          english: params['english']
        )

        record = Translation.where(props.to_h)
        record = Translation.create!(props.to_h) if record.nil?

        TranslationEvent.create!(
          code: 'missing-translation',
          person: 'visitor',
          translation: record
        )
      end

      def update
        forbidden
      end

      def destroy
        forbidden
      end

      private

      def model_class
        TranslationEvent
      end

      def serializer_class
        V1::Public::TranslationEventSerializer
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
        %[]
        # %i[
        #   related_articles
        #   related_products
        #   related_products.main_group
        #   translations
        # ]
      end
    end
  end
end
