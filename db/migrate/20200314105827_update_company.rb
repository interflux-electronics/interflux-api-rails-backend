class UpdateCompany < ActiveRecord::Migration[5.1]
  def change
    rename_column :companies, :name, :business_name
    rename_column :companies, :email, :emails

    add_column :companies, :legal_name, :string
    add_column :companies, :website, :string
  end
end
