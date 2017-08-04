# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :slug
      t.string :language
      t.string :image_url
      t.string :teaser
      t.text :corpus

      t.timestamps
    end
  end
end
