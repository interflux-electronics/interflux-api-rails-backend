

# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string
#  company    :string
#  email      :string
#  website    :string
#  phone      :string
#  fax        :string
#  address    :string
#  country_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Contact < ApplicationRecord
end
