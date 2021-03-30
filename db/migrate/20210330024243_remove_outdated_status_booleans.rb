class RemoveOutdatedStatusBooleans < ActiveRecord::Migration[6.1]
  def up
    change_table :products, bulk: true do |t|
      t.remove :orderable
      t.remove :featured
      t.remove :popular
      t.remove :new
    end
  end

  def down
    change_table :products, bulk: true do |t|
      t.boolean :orderable
      t.boolean :featured
      t.boolean :popular
      t.boolean :new
    end
  end
end
