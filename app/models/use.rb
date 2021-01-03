# == Schema Information
#
# Table name: uses
#
#  slug       :string           not null, primary key
#  text       :string
#  icon       :string
#  gist       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_id   :string
#  rank       :integer
#

class Use < ApplicationRecord
  belongs_to :image, optional: true

  has_many :product_uses, dependent: :destroy
  has_many :products, through: :product_uses, source: :product

  has_many :use_images, dependent: :destroy
  has_many :images, through: :use_images, source: :image

  after_save :update_icon, on: %i[create update]

  private

  # In Admin we assign Image records to Use records.
  # In Public we however don't serve those Image records.
  # Instead we serve the string atrribute "icon".
  # Therefor, each time the relation is saved, als update the attribute.
  def update_icon
    icon = image.present? ? "#{image.path}.svg" : nil
    update_column(:icon, icon)
  end
end
