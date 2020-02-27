class CreateDocumentCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :document_categories, id: :uuid do |t|
      t.string :slug
      t.string :name

      t.timestamps
    end

    add_index :document_categories, :slug, unique: true
    add_index :document_categories, :name, unique: true
  end
end
