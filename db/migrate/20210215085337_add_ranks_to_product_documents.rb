class AddRanksToProductDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :product_documents, :rank_among_products, :integer
    add_column :product_documents, :rank_among_documents, :integer
  end
end
