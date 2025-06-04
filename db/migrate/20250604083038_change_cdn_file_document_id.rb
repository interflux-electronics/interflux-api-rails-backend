class ChangeCdnFileDocumentId < ActiveRecord::Migration[6.1]
  def up
    change_column :cdn_files, :document_id, :uuid, using: 'document_id::uuid'
  end

  def down
    change_column :cdn_files, :document_id, :string
  end
end
