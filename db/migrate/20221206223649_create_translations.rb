class CreateTranslations < ActiveRecord::Migration[5.1]
  def change
    create_table :translations, id: :uuid do |t|
      t.string :key # page.product.h2.summary
      t.string :locale # es
      t.string :native # Resumen
      t.string :english # Summary

      t.boolean :needs_review
      t.string :review_code # untranslated | robot-translated | source-changed | custom
      t.string :custom_review_message # The markup does not look correct...

      t.timestamps
    end

    add_index :translations, :key
    add_index :translations, :locale
  end
end
