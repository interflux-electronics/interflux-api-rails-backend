class CreatePersonImages < ActiveRecord::Migration[5.1]
  def change
    create_table :person_images, id: :uuid do |t|
      t.uuid :person_id
      t.string :image_id

      t.timestamps
    end
  end
end
