class AddGroupWebsiteFieldsToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :shown_on_group_website, :boolean, default: false
    add_column :companies, :core_activity, :string
    add_column :companies, :history, :string
    add_column :companies, :rank_on_group_website, :integer, default: 999
    add_column :companies, :show_markets, :boolean, default: true
  end
end
