class AddFrontpageBooleansToProducts < ActiveRecord::Migration[6.1]
  def change
    change_table :products, bulk: true do |t|
      t.boolean :on_front_page, default: false
      t.integer :front_page_rank, default: 9
    end
  end
end
