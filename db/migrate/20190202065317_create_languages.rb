class CreateLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :languages, id: :uuid do |t|
      t.string :name_english
      t.string :name_native

      t.timestamps
    end

    add_index :languages, :name_english, unique: true
    add_index :languages, :name_native, unique: true
  end
end
