# == Schema Information
#
# Table name: people
#
#  id           :uuid             not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  first_name   :string
#  last_name    :string
#  chinese_name :string
#  email        :string
#  phone        :string
#  male         :boolean
#  full_name    :string
#

class Person < ApplicationRecord
  has_one :user

  has_many :company_members
  has_many :companies, through: :company_members, source: :company

  # To make full name searches possible we update the full name column after every save
  after_save :set_full_name

  def set_full_name
    value = [first_name, last_name, chinese_name].reject(&:nil?).join(' ')

    update_column(:full_name, value)
  end
end
