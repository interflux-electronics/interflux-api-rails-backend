class AddVariationsToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :variations, :string
  end
end
