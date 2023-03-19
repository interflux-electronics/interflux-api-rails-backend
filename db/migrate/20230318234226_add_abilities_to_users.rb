class AddAbilitiesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :abilities, :string
  end
end
