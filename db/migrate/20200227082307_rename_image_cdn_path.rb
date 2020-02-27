class RenameImageCdnPath < ActiveRecord::Migration[5.1]
  def change
    rename_column :images, :cdn_path, :path
  end
end
