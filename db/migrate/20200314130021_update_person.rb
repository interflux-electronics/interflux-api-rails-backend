class UpdatePerson < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :chinese_name, :string
    add_column :people, :email, :string
    add_column :people, :phone, :string
    add_column :people, :male, :boolean
  end
end
