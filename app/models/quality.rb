# == Schema Information
#
# Table name: qualities
#
#  gist       :text
#  icon       :string
#  slug       :string           not null, primary key
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_id   :string
#
class Quality < ApplicationRecord
  belongs_to :image, optional: true

  has_many :product_qualities, dependent: :destroy
  has_many :products, through: :product_qualities, source: :product

  after_save :update_icon

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
