module V1
  module Admin
    class TranslationsController < ApplicationController
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
        allow_update
      end

      def destroy
        forbidden
      end

      def translate
        return missing_param if params[:phrase].blank? || params[:source_lang].blank? || params[:target_lang].blank?

        response = TranslateService.new(params[:phrase], params[:source_lang], params[:target_lang]).call

        return robot_said_no unless response[:success]

        render status: 200, json: response
      end

      private

      def model_class
        Translation
      end

      def serializer_class
        V1::Admin::TranslationSerializer
      end

      def creatable_attributes
        %i[
          location
          language
          native
          english
          english_before
          status
        ]
      end

      def permitted_filters
        %i[
          location
          language
        ]
      end

      def missing_param
        render_error(
          422,
          'missing-param',
          'Please make sure the body of the request has the params: phrase, source_lang and target_lang.'
        )
      end

      def robot_said_no
        render_error(
          422,
          'robot-said-no',
          'Something with the request to Deepl Translator did not go as planned.'
        )
      end
    end
  end
end
