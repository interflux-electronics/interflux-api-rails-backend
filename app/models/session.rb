class Session < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :country, class_name: 'Country', foreign_key: 'ip_country_id', optional: true
end
