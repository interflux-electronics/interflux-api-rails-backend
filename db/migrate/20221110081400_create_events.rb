class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events, id: :uuid do |t|
      t.string :name
      t.string :description
      t.string :dates
      t.string :city
      t.string :country_id

      t.timestamps
    end
  end
end
