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

class Lead < ApplicationRecord
  belongs_to :country, optional: true
  belongs_to :ip_country, class_name: 'Country', foreign_key: 'ip_country_id', optional: true
end
