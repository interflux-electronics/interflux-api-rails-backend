class AddSuperiorProductToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :superior_product_id, :string
  end
end
