class CreateLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :languages, id: :uuid do |t|
      t.string :locale
      t.string :name_english
      t.string :name_native
      t.timestamps
    end
  end
end
