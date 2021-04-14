class AddProductAvatarCacheProperties < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :avatar_path, :string
    add_column :products, :avatar_variations, :string
    add_column :products, :avatar_caption, :string
    add_column :products, :avatar_alt, :string
  end
end
