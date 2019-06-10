class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos, id: :uuid do |t|
      t.string :cdn_path
      t.string :sizes
      t.string :formats
      t.string :tag_long
      t.string :tag_short

      t.string :poster_url

      t.timestamps
    end

    add_index :videos, :cdn_path, unique: true
    add_index :videos, :tag_long, unique: true
  end
end
