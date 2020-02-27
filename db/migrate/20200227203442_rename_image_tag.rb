class RenameImageTag < ActiveRecord::Migration[5.1]
  def change
    rename_column :images, :tag_long, :caption
    rename_column :images, :tag_short, :alt
  end
end
