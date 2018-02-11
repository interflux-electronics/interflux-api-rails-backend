class CreateImageSource < ActiveRecord::Migration[5.1]
  def change
    create_table :image_sources do |t|
      t.string :url
      t.integer :width
      t.integer :height

      t.integer :image_id

      t.timestamps
    end
  end
end
