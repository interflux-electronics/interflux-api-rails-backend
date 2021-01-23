class AddPublicMemberDetails < ActiveRecord::Migration[5.1]
  def change
    change_column_default :company_members, :public, from: nil, to: false

    add_column :company_members, :public_title, :boolean, default: false
    add_column :company_members, :public_email, :boolean, default: false
    add_column :company_members, :public_phone, :boolean, default: false
  end
end
