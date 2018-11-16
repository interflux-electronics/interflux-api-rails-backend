# == Schema Information
#
# Table name: leads
#
#  id            :uuid             not null, primary key
#  name          :text
#  company       :text
#  email         :text
#  mobile        :text
#  message       :text
#  purpose       :text
#  source        :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  country_id    :uuid
#  ip_country_id :uuid
#  ip_region     :text
#  ip_city       :text
#  ip            :text
#

class LeadSerializer < ApplicationSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id,
             :name,
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
