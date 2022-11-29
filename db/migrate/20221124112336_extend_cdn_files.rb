class ExtendCdnFiles < ActiveRecord::Migration[6.1]
  def change
    add_index :cdn_files, :path
    add_column :cdn_files, :user_id, :uuid
    add_column :cdn_files, :locale, :string
    add_column :cdn_files, :original_file_name, :string
  end
end
