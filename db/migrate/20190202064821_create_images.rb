class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images, id: :uuid do |t|
      t.string :path
      t.string :text
      t.string :sizes

      t.timestamps
    end

    add_index :images, :path, unique: true
    add_index :images, :text, unique: true
  end
end
