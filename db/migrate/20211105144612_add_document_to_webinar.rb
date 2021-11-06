class AddDocumentToWebinar < ActiveRecord::Migration[6.1]
  def change
    add_column :webinars, :document_id, :string
  end
end
