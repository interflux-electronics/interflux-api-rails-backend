# https://stackoverflow.com/questions/52248753/rails-5-how-can-i-change-an-existing-models-id-type-to-uuid
# https://stackoverflow.com/questions/15622303/how-to-change-primary-key-in-rails-migration-file
#
class ChangeDocumentPrimaryKeyToUuid < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :id, :uuid, default: 'gen_random_uuid()', null: false

    execute 'ALTER TABLE documents DROP CONSTRAINT documents_pkey'
    execute 'ALTER TABLE documents ADD PRIMARY KEY (id);'
  end
end
