module V1
  module Admin
    class SessionsController < ApplicationController
      def index
        sessions = Session.limit(200).order('created_at desc')

        json = serializer_class.new(sessions, {}).serializable_hash.to_json

        render status: 200, json: json
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
        Session
      end

      def serializer_class
        V1::Admin::SessionSerializer
      end
    end
  end
end
