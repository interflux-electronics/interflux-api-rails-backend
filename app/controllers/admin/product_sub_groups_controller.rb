module Admin
  class ProductSubGroupsController < Admin::AuthenticatedController
    # GET /admin/product_sub_groups
    def index
      @records = ProductSubGroup.all
      @resources = @records.map { |record| ProductSubGroupResource.new(record, nil) }
      render json: JSONAPI::ResourceSerializer.new(Admin::ProductSubGroupResource).serialize_to_hash(@resources)
    end
  end
end
