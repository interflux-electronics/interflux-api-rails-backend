class AddOrderToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :order, :integer
  end
end
