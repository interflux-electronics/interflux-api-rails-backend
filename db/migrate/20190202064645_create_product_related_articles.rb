class CreateProductRelatedArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :product_related_articles, id: :uuid do |t|
      t.uuid :product_id
      t.uuid :article_id

      t.timestamps
    end

    # add_index :products, :slug, unique: true
    # add_index :products, :name, unique: true
    # add_index :products, :public
    # add_index :products, :group_id
  end
end

class CreateProductImages < ActiveRecord::Migration[5.1]
  def change
    create_table :product_images, id: :uuid do |t|
      t.uuid :product_id
      t.uuid :image_id

      t.timestamps
    end

    add_index :product_images, :product_id
    add_index :product_images, :image_id
  end
end
