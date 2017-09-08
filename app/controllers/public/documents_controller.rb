# frozen_string_literal: true

module Public
  class DocumentsController < ApplicationController
    # GET /public/documents
    def index
      @document_type = params['document_type']
      @documents = Document.where(public: true)
      @documents = @documents.where(document_type: @document_type) if @document_type.present?
      @document_resources = @documents.map { |document| DocumentResource.new(document, nil) }
      render json: JSONAPI::ResourceSerializer.new(DocumentResource).serialize_to_hash(@document_resources)
    end
  end
end
