class AddAvatarToPeople < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :image_id, :string
    add_column :people, :avatar_path, :string
    add_column :people, :avatar_variations, :string
    add_column :people, :avatar_caption, :string
    add_column :people, :avatar_alt, :string
  end
end
