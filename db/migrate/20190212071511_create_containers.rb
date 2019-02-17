class CreateContainers < ActiveRecord::Migration[5.1]
  def change
    create_table :containers, id: :uuid do |t|
      t.string :name

      t.timestamps
    end

    add_index :containers, :name, unique: true
  end
end
