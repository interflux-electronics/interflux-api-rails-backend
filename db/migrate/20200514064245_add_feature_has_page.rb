class AddFeatureHasPage < ActiveRecord::Migration[5.1]
  def change
    add_column :features, :has_page, :boolean
  end
end
