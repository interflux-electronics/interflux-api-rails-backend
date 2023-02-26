class RenameAndRemoveFromTranslation < ActiveRecord::Migration[6.1]
  def change
    remove_column :translations, :history
    rename_column :translations, :last_english_approved, :english_before
  end
end
