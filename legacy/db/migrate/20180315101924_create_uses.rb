class CreateUses < ActiveRecord::Migration[5.1]
  def change
    create_table :uses, id: :uuid do |t|
      t.string :slug
      t.string :name
      t.timestamps
    end
  end
end
