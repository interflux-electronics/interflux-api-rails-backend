class CreateArticleRelatedArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :article_related_articles, id: :uuid do |t|
      t.uuid :article_id
      t.uuid :related_article_id

      t.timestamps
    end

    add_index :article_related_articles, :article_id
    add_index :article_related_articles, :related_article_id
  end
end
