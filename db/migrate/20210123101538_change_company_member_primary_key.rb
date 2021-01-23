class ChangeCompanyMemberPrimaryKey < ActiveRecord::Migration[5.1]
  def change
    add_column :company_members, :uuid, :uuid, default: 'gen_random_uuid()', null: false

    change_table :company_members do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute 'ALTER TABLE company_members ADD PRIMARY KEY (id);'
  end
end
