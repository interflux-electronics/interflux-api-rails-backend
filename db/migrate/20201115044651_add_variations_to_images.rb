class AddVariationsToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :variations, :string
  end
end
