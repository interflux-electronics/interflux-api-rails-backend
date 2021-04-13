class RemoveObsoleteImageColumns < ActiveRecord::Migration[6.1]
  def change
    remove_column :images, :sizes, :string
    remove_column :images, :formats, :string
  end
end
