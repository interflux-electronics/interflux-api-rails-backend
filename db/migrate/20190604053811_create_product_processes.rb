class CreateProductProcesses < ActiveRecord::Migration[5.1]
  def change
    create_table :product_processes, id: :uuid do |t|
      t.uuid :product_id
      t.uuid :soldering_process_id

      t.timestamps
    end

    add_index :product_processes, :product_id
    add_index :product_processes, :soldering_process_id
  end
end
