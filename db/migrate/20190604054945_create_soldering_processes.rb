class CreateSolderingProcesses < ActiveRecord::Migration[5.1]
  def change
    create_table :soldering_processes, id: :uuid do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end

    add_index :soldering_processes, :slug, unique: true
    add_index :soldering_processes, :name, unique: true
  end
end
