class AddDocumentAndImageIdToCdnFiles < ActiveRecord::Migration[5.1]
  def change
    add_column :cdn_files, :image_id, :string
    add_column :cdn_files, :document_id, :string
  end
end
