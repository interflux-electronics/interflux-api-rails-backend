# frozen_string_literal: true

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
#  country_id :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Contact < ApplicationRecord
end
