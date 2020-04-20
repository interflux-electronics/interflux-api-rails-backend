class AddFeatureCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :features, :category, :string
  end
end
