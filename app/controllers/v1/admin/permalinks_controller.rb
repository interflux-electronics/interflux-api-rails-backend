module V1
  module Admin
    class PermalinksController < ApplicationController
      def index
        allow_index
      end

      def show
        allow_show
      end

      def create
        allow_create(
          {
            slug: unique_slug
          }
        )
      end

      def update
        allow_update
      end

      def destroy
        forbidden
      end

      private

      def model_class
        Permalink
      end

      def serializer_class
        V1::Admin::PermalinkSerializer
      end

      def creatable_attributes
        %i[
          slug
          redirect_to
          notes
        ]
      end

      def creatable_relationships
        %i[
          event
        ]
      end

      def permitted_filters
        %i[
          slug
        ]
      end

      def unique_slug
        slug = nil
        unique = false

        until slug.present? && unique
          slug = three_random_letters
          record = Permalink.find_by slug: slug
          unique = record.nil?
        end

        slug
      end

      def three_random_letters
        charset = Array('A'..'Z') + Array('a'..'z')
        Array.new(3) { charset.sample }.join
      end
    end
  end
end
