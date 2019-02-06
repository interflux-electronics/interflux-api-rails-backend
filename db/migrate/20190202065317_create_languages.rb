class CreateLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :languages, id: :uuid do |t|
      t.string :name_english
      t.string :name_native
      t.string :iso_639_1_code
      t.string :iso_639_2_code

      t.boolean :public, default: false

      t.timestamps
    end

    add_index :languages, :iso_639_1_code, unique: true
    add_index :languages, :iso_639_2_code, unique: true
    add_index :languages, :public
  end
end
