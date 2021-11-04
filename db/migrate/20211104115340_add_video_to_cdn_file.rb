class AddVideoToCdnFile < ActiveRecord::Migration[6.1]
  def change
    add_column :cdn_files, :video_id, :string
  end
end
