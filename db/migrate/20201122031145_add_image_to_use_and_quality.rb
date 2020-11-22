class AddImageToUseAndQuality < ActiveRecord::Migration[5.1]
  def change
    add_column :qualities, :image_id, :string
    add_column :uses, :image_id, :string
  end
end
