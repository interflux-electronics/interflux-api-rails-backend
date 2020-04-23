# drop_table :products
# drop_table :product_families
# drop_table :product_features
# drop_table :product_documents
# drop_table :product_images
# drop_table :product_variant
# drop_table :documents
# drop_table :feature
# drop_table :image

class RecreateProductsAndRelated < ActiveRecord::Migration[5.1]
  def change
    create_table :products, id: :string, primary_key: 'slug' do |t|
      t.string :name
      t.string :product_family_id
      t.string :label
      t.text :pitch
      t.text :properties

      t.boolean :public, default: false
      t.boolean :orderable, default: false
      t.boolean :featured, default: false
      t.boolean :popular, default: false
      t.boolean :new, default: false

      t.timestamps
    end

    create_table :product_families, id: :string, primary_key: 'slug' do |t|
      t.string :name_single
      t.string :name_plural
      t.boolean :public, default: false
      t.integer :order

      t.timestamps
    end

    create_table :product_features, id: :uuid do |t|
      t.string :product_id
      t.string :feature_id

      t.timestamps
    end

    create_table :features, id: :string, primary_key: 'slug' do |t|
      t.string :text
      t.string :icon
      t.string :gist
      t.string :category

      t.timestamps
    end

    create_table :product_images, id: :uuid do |t|
      t.string :product_id
      t.string :image_id

      t.timestamps
    end

    create_table :images, id: :string, primary_key: 'path' do |t|
      t.string :sizes
      t.string :formats
      t.string :caption
      t.string :alt

      t.timestamps
    end

    create_table :product_documents, id: :uuid do |t|
      t.string :product_id
      t.string :document_id

      t.timestamps
    end

    create_table :documents, id: :string, primary_key: 'path' do |t|
      t.string :name
      t.uuid :language_id
      t.uuid :document_category_id

      t.timestamps
    end
  end
end
