class AddFullNameToPerson < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :full_name, :string
  end
end
