class RenameTranslationKeyColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :translations, :key, :location
  end
end
