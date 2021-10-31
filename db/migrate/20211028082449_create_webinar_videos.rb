class CreateWebinarVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :webinar_videos, id: :uuid do |t|
      t.uuid :webinar_id
      t.uuid :video_id

      t.timestamps
    end
  end
end
