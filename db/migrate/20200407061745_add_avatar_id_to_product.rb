class AddAvatarIdToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :image_id, :uuid
  end
end
