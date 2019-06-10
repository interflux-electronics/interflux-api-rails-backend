class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images, id: :uuid do |t|
      t.string :cdn_path
      t.string :sizes
      t.string :formats
      t.string :tag_long
      t.string :tag_short

      t.timestamps
    end

    add_index :images, :cdn_path, unique: true
    add_index :images, :tag_long, unique: true
  end
end
