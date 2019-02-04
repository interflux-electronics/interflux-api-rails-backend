class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags, id: :uuid do |t|
      t.string :slug
      t.string :name

      t.timestamps
    end

    add_index :tags, :slug, unique: true
  end
end
