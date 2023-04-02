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
