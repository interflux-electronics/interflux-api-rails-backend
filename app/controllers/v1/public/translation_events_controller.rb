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
          location: params['location'],
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
    end
  end
end
