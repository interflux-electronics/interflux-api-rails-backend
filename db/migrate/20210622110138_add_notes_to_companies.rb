class AddNotesToCompanies < ActiveRecord::Migration[6.1]
  def change
    change_table :companies, bulk: true do |t|
      t.text :description
      t.text :notes
    end
  end
end
