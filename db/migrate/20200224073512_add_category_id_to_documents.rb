class AddCategoryIdToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :category_id, :uuid
  end
end
