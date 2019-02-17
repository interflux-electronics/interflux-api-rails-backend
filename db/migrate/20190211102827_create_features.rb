class CreateFeatures < ActiveRecord::Migration[5.1]
  def change
    create_table :features, id: :uuid do |t|
      t.string :slug
      t.string :text
      t.string :icon
      t.text :gist

      t.timestamps
    end

    add_index :features, :slug, unique: true
    add_index :features, :text, unique: true
  end
end
