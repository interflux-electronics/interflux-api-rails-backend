class CreateLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :languages, id: :uuid do |t|
      t.string :slug
      t.string :name_english
      t.string :name_native
      t.boolean :supported
    end

    add_index :languages, :slug, unique: true
  end
end
