class DropProductsAndRelated < ActiveRecord::Migration[5.1]
  def up
    # For renewing the Primary keys to slugs
    drop_table :products
    drop_table :product_families
    drop_table :product_features
    drop_table :product_documents
    drop_table :product_images
    drop_table :product_variants
    drop_table :documents
    drop_table :features
    drop_table :images

    # Because unused
    drop_table :product_uses
    drop_table :uses
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
