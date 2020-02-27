class RemoveImageCaptionIndex < ActiveRecord::Migration[5.1]
  def change
    remove_index :images, :caption
  end
end
