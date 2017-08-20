# frozen_string_literal: true

class Public
  class LeadsController < ApplicationController
    # POST /public/lead
    def create
      @lead = Lead.create!(lead_params)
      json_response(@lead, :created)
    end

    def lead_params
      params.permit(
        :company,
        :country,
        :email,
        :name,
        :phone
      )
    end
  end
end
