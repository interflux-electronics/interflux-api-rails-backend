class DropVideos < ActiveRecord::Migration[6.1]
  def change
    drop_table :videos
  end
end
