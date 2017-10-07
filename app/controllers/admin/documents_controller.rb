# frozen_string_literal: true

module Admin
  class DocumentsController < Admin::ApplicationController
    before_action :set_document, only: %i[show update destroy]

    # GET /admin/documents
    def index
      @documents = Document.all
      @document_resources = @documents.map { |document| DocumentResource.new(document, nil) }
      render json: JSONAPI::ResourceSerializer.new(Admin::DocumentResource).serialize_to_hash(@document_resources)
    end

    # GET /admin/documents/:id
    def show
      json = JSONAPI::ResourceSerializer.new(Admin::DocumentResource).serialize_to_hash(Admin::DocumentResource.new(@document, nil))
      render json: json, status: 200
    end

    # POST /admin/documents
    def create
      @new_document = Document.create!(document_params)
      json = JSONAPI::ResourceSerializer.new(Admin::DocumentResource).serialize_to_hash(Admin::DocumentResource.new(@new_document, nil))
      render json: json, status: 201
    end

    # PUT /admin/documents/:id
    def update
      @document.update(document_params)
      head 204
    end

    # DELETE /admin/documents/:id
    def destroy
      @document.destroy
      head 204
    end

    private

    def set_document
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:data)
            .require(:attributes)
            .permit(
              :name,
              :url,
              :public,
              :document_type
            )
    end
  end
end
