# == Schema Information
#
# Table name: videos
#
#  notes      :string
#  path       :string           not null, primary key
#  title      :string
#  variations :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Video < ApplicationRecord
  belongs_to :webinar, optional: true
  has_many :product_videos, dependent: :destroy
  has_many :products, through: :product_videos, source: :product
end
