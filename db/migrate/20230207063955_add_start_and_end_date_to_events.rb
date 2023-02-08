class AddStartAndEndDateToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :start_date, :string
    add_column :events, :end_date, :string
  end
end
