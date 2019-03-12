class CreateProductRelatedArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :product_related_articles, id: :uuid do |t|
      t.uuid :product_serie_id
      t.uuid :article_id

      t.timestamps
    end

    add_index :product_related_articles, :product_serie_id
    add_index :product_related_articles, :article_id
  end
end
