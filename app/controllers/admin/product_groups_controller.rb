

module Admin
  class ProductGroupsController < Admin::AuthenticatedController
    # GET /admin/product_groups
    def index
      @records = ProductGroup.all
      @resources = @records.map { |record| ProductGroupResource.new(record, nil) }
      render json: JSONAPI::ResourceSerializer.new(Admin::ProductGroupResource).serialize_to_hash(@resources)
    end
  end
end
