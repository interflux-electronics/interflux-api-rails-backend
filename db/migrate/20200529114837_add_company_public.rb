class AddCompanyPublic < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :public, :boolean
  end
end
