class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events, id: :uuid do |t|
      t.string :name
      t.string :start_date
      t.string :end_date
      t.string :location
      t.string :call_to_action

      t.timestamps
    end
  end
end
