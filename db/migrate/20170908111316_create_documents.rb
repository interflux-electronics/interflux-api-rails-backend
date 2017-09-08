# frozen_string_literal: true

class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :name
      t.string :url
      t.string :document_type
      t.string :locale
      t.boolean :public

      t.timestamps
    end
  end
end
