class CreateProductDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :product_documents, id: :uuid do |t|
      t.uuid :product_id
      t.uuid :document_id

      t.timestamps
    end

    add_index :product_documents, :product_id
    add_index :product_documents, :document_id
  end
end
