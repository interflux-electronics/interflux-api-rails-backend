# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  abilities       :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  person_id       :uuid
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_secure_password

  belongs_to :person, optional: true

  # https://github.com/carrierwaveuploader/carrierwave
  # mount_uploader :avatar, AvatarUploader

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, if: -> { new_record? || !password.nil? }

  def can?(ability)
    abilities.split(',').include?(ability)
  end
end
