class CreateUseImages < ActiveRecord::Migration[5.1]
  def change
    create_table :use_images, id: :uuid do |t|
      t.string :use_id
      t.string :image_id

      t.timestamps
    end
  end
end
