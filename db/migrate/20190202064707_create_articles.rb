class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles, id: :uuid do |t|
      t.string :slug
      t.string :title
      t.boolean :public, default: false

      t.uuid :person_id

      t.timestamps
    end

    add_index :articles, :slug, unique: true
    add_index :articles, :title, unique: true
    add_index :articles, :person_id
  end
end
