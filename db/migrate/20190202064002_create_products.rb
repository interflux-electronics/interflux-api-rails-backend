class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products, id: :uuid do |t|
      t.string :slug
      t.string :code
      t.string :name
      t.boolean :public, default: false
      t.boolean :continued, default: true

      t.uuid :product_family_id

      t.timestamps
    end

    add_index :products, :slug, unique: true
    add_index :products, :code, unique: true
    add_index :products, :name, unique: true
    add_index :products, :public
    add_index :products, :continued
    add_index :products, :product_family_id
  end
end
