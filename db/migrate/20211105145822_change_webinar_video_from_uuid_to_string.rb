class ChangeWebinarVideoFromUuidToString < ActiveRecord::Migration[6.1]
  def change
    change_column :webinars, :video_id, :string
  end
end
