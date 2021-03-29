class AddContentToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :summary, :string
    add_column :products, :instructions, :string
  end
end
