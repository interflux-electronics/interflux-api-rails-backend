class MakeLocationUniqueOnTranslationsPerLanguage < ActiveRecord::Migration[6.1]
  def change
    remove_column :translations, :needs_review
    remove_column :translations, :review_code
    remove_column :translations, :custom_review_message

    add_column :translations, :status, :string
    add_column :translations, :history, :text
    add_column :translations, :last_english_approved, :text

    remove_index :translations, name: 'unique_translation_index'

    add_index :translations,
              %i[language location],
              unique: true,
              name: 'unique_location_per_language_index'
  end
end
