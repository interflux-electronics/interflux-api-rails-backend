class DropDocumentCategories < ActiveRecord::Migration[5.1]
  def up
    drop_table :document_categories
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
