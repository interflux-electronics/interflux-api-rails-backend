class AddRankPublicToProductVideo < ActiveRecord::Migration[6.1]
  def change
    add_column :product_videos, :rank, :integer
    add_column :product_videos, :public, :boolean

    remove_index :product_videos, name: 'index_product_videos_on_product_id'
    remove_index :product_videos, name: 'index_product_videos_on_video_id'

    remove_column :product_videos, :created_at
    remove_column :product_videos, :updated_at
  end
end
