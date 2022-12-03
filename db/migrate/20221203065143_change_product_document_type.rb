class ChangeProductDocumentType < ActiveRecord::Migration[6.1]
  def self.up
    change_column :product_documents, :document_id, :uuid, using: 'document_id::uuid'
  end

  def self.down
    change_column :product_documents, :document_id, :string, using: 'document_id::string'
  end
end
