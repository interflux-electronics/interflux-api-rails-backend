# frozen_string_literal: true

class CreateLanguage < ActiveRecord::Migration[5.1]
  def change
    create_table :languages do |t|
      t.string :locale
      t.string :name_english
      t.string :name_native
    end
  end
end
