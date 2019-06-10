class CreateProductVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :product_videos, id: :uuid do |t|
      t.uuid :product_id
      t.uuid :video_id

      t.timestamps
    end

    add_index :product_videos, :product_id
    add_index :product_videos, :video_id
  end
end
