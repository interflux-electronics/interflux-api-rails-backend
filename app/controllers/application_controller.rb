# frozen_string_literal: true

class ApplicationController < JSONAPI::ResourceController

  # Serialise and return 1 record into JSON using JSON API resources
  # Example: render status: 200, json: json_resource(Admin::ProductResource, @product, nil)
  def json_resource(klass, record, context = nil)
    JSONAPI::ResourceSerializer.new(klass).serialize_to_hash(klass.new(record, context))
  end

  # Serialise and return an array of records into JSON using JSON API resources
  # Example: render status: 200, json: json_resources(Admin::ProductResource, @products, nil)
  def json_resources(klass, records, context = nil)
    resources = records.map { |record| klass.new(record, context) }
    JSONAPI::ResourceSerializer.new(klass).serialize_to_hash(resources)
  end

	# Wraps a single error in JSON API format
  # How to use:
  # render status: 401, json: json_error({
  #   code: 'unauthorised',
  #   detail: 'Patients must be signed in in order to see, create and update appointments.'
  # })
  def json_error(error)
    { errors: [error] }
  end

  # Converts the errors on a resource to a valid JSON API error response
  # How to use:
  # suburb.errors.add(:postcode, 'Message for users',
  #                   error: {
  #                     code: 'error_code_1',
  #                     detail: 'Message for developers.',
  #                     meta: { extras: 'details' }
  #                   })
  def json_errors(resource)
    @errors = []
    resource.errors.details.map do |_association, errors|
      errors.map do |detail|
        next if detail[:error].blank?
        @errors.push(detail[:error])
      end
    end.flatten
    { errors: @errors }
  end

end
