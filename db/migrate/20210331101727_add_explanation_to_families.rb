class AddExplanationToFamilies < ActiveRecord::Migration[6.1]
  def change
    add_column :product_families, :the_full_monty, :string
  end
end
