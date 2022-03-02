class AddIsHeadquarterToCompanies < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :is_headquarter, :boolean, default: false
  end
end
