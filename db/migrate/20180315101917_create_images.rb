class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images, id: :uuid do |t|
      t.uuid :image_owner_id
      t.string :image_owner_type
      t.string :alt
      t.timestamps
    end

    create_table :image_sources, id: :uuid do |t|
      t.string :url
      t.integer :width
      t.integer :height
      t.uuid :image_id
      t.timestamps
    end

    create_table :image_translations, id: :uuid do |t|
      t.string :alt
      t.uuid :image_id
      t.uuid :language_id
      t.timestamps
    end
  end
end
