class RecreateDocumentCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :document_categories, id: :string, primary_key: 'slug' do |t|
      # t.string :slug
      t.string :name
      t.string :gist
      t.string :icon
      t.integer :order

      t.timestamps
    end
  end
end
