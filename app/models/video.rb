class Video < ApplicationRecord
  belongs_to :webinar, optional: true
  has_many :product_videos, dependent: :destroy
  has_many :products, through: :product_videos, source: :product
end
