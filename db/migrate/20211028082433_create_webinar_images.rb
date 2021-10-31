class CreateWebinarImages < ActiveRecord::Migration[5.1]
  def change
    create_table :webinar_images, id: :uuid do |t|
      t.uuid :webinar_id
      t.uuid :image_id

      t.timestamps
    end
  end
end
