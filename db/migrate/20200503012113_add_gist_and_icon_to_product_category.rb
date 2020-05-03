class AddGistAndIconToProductCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :document_categories, :gist, :string
    add_column :document_categories, :icon, :string
    add_column :document_categories, :order, :integer
  end
end
