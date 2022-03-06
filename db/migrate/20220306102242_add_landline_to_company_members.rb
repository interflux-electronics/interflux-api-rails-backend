class AddLandlineToCompanyMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :company_members, :landline, :string
    add_column :company_members, :public_landline, :boolean, default: false
  end
end
