class CreateProductDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :product_documents, id: :uuid do |t|
      # t.string :slug
      # t.string :name
      # t.boolean :public, default: false

      # t.uuid :group_id

      # t.timestamps
    end

    # add_index :products, :slug, unique: true
    # add_index :products, :name, unique: true
    # add_index :products, :public
    # add_index :products, :group_id
  end
end
