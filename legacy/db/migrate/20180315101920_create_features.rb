class CreateFeatures < ActiveRecord::Migration[5.1]
  def change
    create_table :features, id: :uuid do |t|
      t.string :label
      t.string :icon
      t.timestamps
    end
  end
end
