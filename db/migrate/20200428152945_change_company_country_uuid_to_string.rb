class ChangeCompanyCountryUuidToString < ActiveRecord::Migration[5.1]
  def change
    change_column :companies, :country_id, :string
  end
end
