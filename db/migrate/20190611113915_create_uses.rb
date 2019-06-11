class CreateUses < ActiveRecord::Migration[5.1]
  def change
    create_table :uses, id: :uuid do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end

    add_index :uses, :name, unique: true
    add_index :uses, :slug, unique: true
  end
end
