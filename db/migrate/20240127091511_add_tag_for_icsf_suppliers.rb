class AddTagForIcsfSuppliers < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :shown_on_icsf_website, :boolean, default: false
  end
end
