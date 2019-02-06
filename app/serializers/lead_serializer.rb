# == Schema Information
#
# Table name: leads
#
#  id            :uuid             not null, primary key
#  name          :string
#  company       :string
#  email         :string
#  mobile        :string
#  message       :text
#  purpose       :string
#  source        :string
#  ip_region     :string
#  ip_city       :string
#  ip            :string
#  country_id    :uuid
#  ip_country_id :uuid
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class LeadSerializer < ApplicationSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name,
             :company,
             :email,
             :mobile,
             :message,
             :purpose,
             :source,
             :ip,
             :ip_region,
             :ip_city

  belongs_to :country
  belongs_to :ip_country, record_type: :country
end
