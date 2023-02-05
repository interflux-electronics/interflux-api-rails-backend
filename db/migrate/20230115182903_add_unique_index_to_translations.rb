# https://boringrails.com/tips/rails-unique-scope
# https://stackoverflow.com/questions/48266722/validate-uniqueness-of-a-value-with-scope-ruby-on-rails-5
class AddUniqueIndexToTranslations < ActiveRecord::Migration[6.1]
  def change
    add_index :translations,
              %i[language english],
              unique: true,
              name: 'unique_translation_index'
  end
end
