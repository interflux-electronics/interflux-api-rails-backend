class CreateProductTranslations < ActiveRecord::Migration[5.1]
  def change
    create_table :product_translations, id: :uuid do |t|
      t.string :slug
      t.string :name
      t.string :pitch

      t.uuid :product_id
      t.uuid :language_id
    end

    add_index :product_translations, :slug, unique: true
  end
end
