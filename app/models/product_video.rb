# == Schema Information
#
# Table name: product_videos
#
#  id         :uuid             not null, primary key
#  public     :boolean
#  rank       :integer
#  product_id :string
#  video_id   :string
#
class ProductVideo < ApplicationRecord
  belongs_to :product
  belongs_to :video
end
