class CreateTranslations < ActiveRecord::Migration[5.1]
  def change
    create_table :translations, id: :uuid do |t|
      t.string :slug
      t.string :en
      t.string :de
      t.string :fr
      t.string :zh
      t.string :cs
      t.string :it
      t.string :ind
      t.string :pt
      t.string :ro
      t.string :ru
      t.string :th
      t.string :tr
      t.string :pl
      t.string :es
      t.string :sv
      t.timestamps
    end
  end
end
