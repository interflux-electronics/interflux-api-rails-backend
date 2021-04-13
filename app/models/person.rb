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
