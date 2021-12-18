class AddAlternativeProductAvatar < ActiveRecord::Migration[6.1]
  def change
    add_column :product_uses, :image_id, :string
    add_column :product_uses, :show_alternative_avatar, :boolean, default: false
  end
end
