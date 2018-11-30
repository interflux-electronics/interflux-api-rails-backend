class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles, id: :uuid do |t|
      t.string :slug
      t.string :title
      t.string :tease

      t.uuid :author_id

      t.timestamps
    end

    add_index :articles, :slug, unique: true
    add_index :articles, :title, unique: true
    add_index :articles, :author_id
  end
end
