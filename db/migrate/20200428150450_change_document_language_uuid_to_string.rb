class ChangeDocumentLanguageUuidToString < ActiveRecord::Migration[5.1]
  def change
    change_column :documents, :language_id, :string
  end
end
