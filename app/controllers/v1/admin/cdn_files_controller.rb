module V1
  module Admin
    class CdnFilesController < ApplicationController
      def index
        allow_index
      end

      def show
        allow_show
      end

      def create
        allow_create
      end

      def update
        allow_update
      end

      def destroy
        allow_destroy
      end

      # This endpoint accepts a file name and returns a presigned URL for uploading
      # a file from the front-end directly to the Digital Ocean CDN.
      #
      # Documentation
      # https://docs.digitalocean.com/products/spaces/reference/s3-sdk-examples/
      # https://stackoverflow.com/questions/66555915/cannot-upload-files-with-acl-public-read-to-digital-ocean-spaces
      #
      def create_upload_url
        return if params[:cdn_path].blank?

        file = params[:cdn_path].gsub(/\s+/, '-')

        client = Aws::S3::Client.new(
          access_key_id: ENV['DO_ACCESS'],
          secret_access_key: ENV['DO_SECRET'],
          endpoint: ENV['DO_ENDPOINT'],
          force_path_style: false,
          region: ENV['DO_REGION']
        )

        signer = Aws::S3::Presigner.new(client: client)

        url = signer.presigned_url(
          :put_object,
          bucket: ENV['DO_BUCKET'],
          key: file,
          expires_in: 300
        )

        render json: { url: url }, status: :ok
      end

      private

      def model_class
        CdnFile
      end

      def serializer_class
        V1::Admin::CdnFileSerializer
      end

      def creatable_attributes
        %i[
          path
          locale
          original_file_name
        ]
      end

      def creatable_relationships
        %i[
          user
          document
        ]
      end
    end
  end
end
