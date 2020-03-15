class CreateCompanyMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :company_members do |t|
      t.uuid :company_id
      t.uuid :person_id

      t.string :title
      t.string :email
      t.string :phone

      t.boolean :public
      t.boolean :public_title
      t.boolean :public_email
      t.boolean :public_phone

      t.timestamps
    end

    add_index :company_members, :company_id
    add_index :company_members, :person_id
  end
end
