class RenameAndDeleteVideoColumns < ActiveRecord::Migration[6.1]
  def change
    rename_column :videos, :title_public, :title
    rename_column :videos, :title_admin, :notes
    remove_column :videos, :poster_url
  end
end
