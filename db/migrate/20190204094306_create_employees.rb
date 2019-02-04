class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees, id: :uuid do |t|
      t.uuid :company_id
      t.uuid :person_id

      t.timestamps
    end

    add_index :employees, :company_id
    add_index :employees, :person_id
  end
end
