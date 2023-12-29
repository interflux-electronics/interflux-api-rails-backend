class ChangeProductVideoUuids < ActiveRecord::Migration[6.1]
  def change
    change_column(:product_videos, :product_id, :string)
    change_column(:product_videos, :video_id, :string)
  end
end
