class AddPublicToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :public, :boolean, default: false
  end
end
