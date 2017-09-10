# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :company
      t.string :email
      t.string :website
      t.string :phone
      t.string :fax
      t.string :address
      t.string :country_id

      t.timestamps
    end
  end
end
