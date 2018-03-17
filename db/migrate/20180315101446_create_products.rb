class CreateProducts < ActiveRecord::Migration[5.1]
  def change

    create_table :products, id: :uuid do |t|
      t.string :name
      t.string :slug
      t.boolean :public, default: false
      t.text :pitch
      t.text :body
      t.uuid :avatar_image_id
      t.uuid :main_category_id
      t.uuid :sub_category_id
      t.timestamps
    end

    create_table :product_translations, id: :uuid do |t|
      t.text :body
      t.text :pitch
      t.uuid :product_id
      t.uuid :language_id
      t.timestamps
    end

    create_table :product_categories, id: :uuid do |t|
      t.string :slug
      t.string :name_plural
      t.string :name_single
      t.uuid :parent_category_id
      t.timestamps
    end

    # create_table :product_images, id: :uuid do |t|
    #   t.uuid :product_id
    #   t.uuid :image_id
    #   t.timestamps
    # end

    # create_table :product_uses, id: :uuid do |t|
    #   t.uuid :product_id
    #   t.uuid :use_id
    #   t.timestamps
    # end

  end
end
