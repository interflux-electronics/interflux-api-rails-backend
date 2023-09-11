class AddMainAndSubFamiliesToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :main_family_id, :string
    add_column :products, :sub_family_id, :string
  end
end
