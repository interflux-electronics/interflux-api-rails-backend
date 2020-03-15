class UpdateCompanyMember < ActiveRecord::Migration[5.1]
  def change
    remove_column :company_members, :public_title
    remove_column :company_members, :public_email
    remove_column :company_members, :public_phone
  end
end
