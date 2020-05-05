class ChangeDocumentCategoryFromUuidToString < ActiveRecord::Migration[5.1]
  def change
    change_column :documents, :document_category_id, :string
  end
end
