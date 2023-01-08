class ChangeColumnNames < ActiveRecord::Migration[6.1]
  def change
    rename_column :translations, :locale, :language
    rename_column :translation_events, :updated_by, :person
  end
end
