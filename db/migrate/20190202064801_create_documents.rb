class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents, id: :uuid do |t|
      t.string :path
      t.string :name

      t.uuid :language_id

      t.timestamps
    end

    add_index :documents, :path, unique: true
    add_index :documents, :name, unique: true
    add_index :documents, :language_id
  end
end
