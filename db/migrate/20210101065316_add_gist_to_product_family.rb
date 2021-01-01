class AddGistToProductFamily < ActiveRecord::Migration[5.1]
  def change
    add_column :product_families, :gist, :string
  end
end
