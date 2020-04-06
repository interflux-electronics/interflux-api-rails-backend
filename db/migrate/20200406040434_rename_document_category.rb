class RenameDocumentCategory < ActiveRecord::Migration[5.1]
  def change
    rename_column :documents, :category_id, :document_category_id
  end
end
