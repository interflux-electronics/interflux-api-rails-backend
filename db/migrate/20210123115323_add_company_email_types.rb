class AddCompanyEmailTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :email_general, :string
    add_column :companies, :email_support, :string
    add_column :companies, :email_orders, :string
    add_column :companies, :email_accounting, :string
  end
end
