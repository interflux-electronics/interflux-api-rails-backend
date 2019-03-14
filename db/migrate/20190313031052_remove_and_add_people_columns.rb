class RemoveAndAddPeopleColumns < ActiveRecord::Migration[5.1]
  def change
    remove_index :people, :slug
    remove_index :people, :email
    remove_index :people, :country_id

    remove_column :people, :slug
    remove_column :people, :name
    remove_column :people, :email
    remove_column :people, :mobile
    remove_column :people, :address
    remove_column :people, :country_id

    add_column :people, :first_name, :string
    add_column :people, :last_name, :string
  end
end
