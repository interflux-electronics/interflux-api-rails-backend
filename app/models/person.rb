# == Schema Information
#
# Table name: people
#
#  id         :uuid             not null, primary key
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Person < ApplicationRecord
  has_one :author

  has_many :article, through: :author

  validates :author, presence: true
  validates :article, presence: true
end
