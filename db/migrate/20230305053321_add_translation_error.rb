class AddTranslationError < ActiveRecord::Migration[6.1]
  def change
    add_column :translations, :error, :string
  end
end
