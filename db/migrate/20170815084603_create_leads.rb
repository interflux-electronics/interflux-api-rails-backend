# frozen_string_literal: true

class CreateLeads < ActiveRecord::Migration[5.1]
  def change
    create_table :leads do |t|
      t.string :name
      t.string :company
      t.string :country
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
