class AddImageAndVideoToWebinar < ActiveRecord::Migration[6.1]
  def change
    add_column :webinars, :image_id, :string
    add_column :webinars, :video_id, :uuid
  end
end
