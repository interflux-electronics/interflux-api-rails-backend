class Person < ApplicationRecord
  has_one :user

  has_many :company_members
  has_many :companies, through: :company_members, source: :company

  has_many :person_images
  has_many :images, through: :person_images, source: :image

  belongs_to :image, optional: true
  alias_attribute :avatar, :image

  # To make full name searches possible we update the full name column after every save
  after_save :set_full_name, :set_avatar_props

  def set_full_name
    value = [first_name, last_name, chinese_name].reject(&:nil?).join(' ')

    update_column(:full_name, value)
  end

  def set_avatar_props
    return if image.nil?
    
    update_column(:avatar_path, image.path)
    update_column(:avatar_variations, image.variations)
    update_column(:avatar_caption, image.caption)
    update_column(:avatar_alt, image.alt)
  end
end
