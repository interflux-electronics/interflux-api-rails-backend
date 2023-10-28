class AddShowOnPublicToCompanies < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :shown_on_main_website, :boolean, default: false
  end
end
