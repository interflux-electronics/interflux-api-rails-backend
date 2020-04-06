class CreateArticleCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :article_categories, id: :uuid do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end

    add_index :article_categories, :slug, unique: true
    add_index :article_categories, :name, unique: true
  end
end
