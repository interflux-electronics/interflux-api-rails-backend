class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people, id: :uuid do |t|
      t.string :slug
      t.string :name
      t.string :email
      t.string :mobile
      t.string :address

      t.uuid :country_id

      t.timestamps
    end

    add_index :people, :slug, unique: true
    add_index :people, :name, unique: true
    add_index :people, :email, unique: true
    add_index :people, :country_id
  end
end
