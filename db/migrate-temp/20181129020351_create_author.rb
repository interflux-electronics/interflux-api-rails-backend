class CreateAuthor < ActiveRecord::Migration[5.1]
  def change
    create_table :authors, id: :uuid do |t|
      t.string :tagline

      t.uuid :person_id

      t.timestamps
    end

    add_index :authors, :person_id
  end
end
