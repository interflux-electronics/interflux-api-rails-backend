class CreateImageTranslation < ActiveRecord::Migration[5.1]
  def change
    create_table :image_translations do |t|
      t.string :caption

      t.integer :image_id
      t.integer :language_id

      t.timestamps
    end
  end
end
