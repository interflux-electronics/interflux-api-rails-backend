class AddUniqueConstraintsToPermalinks < ActiveRecord::Migration[6.1]
  def change
    add_index :permalinks, :slug, unique: true
  end
end
