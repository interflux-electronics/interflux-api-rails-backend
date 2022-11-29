class ExtendDocumentCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :document_categories, :name_single, :string
  end
end
