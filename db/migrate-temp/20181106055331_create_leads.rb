class CreateLeads < ActiveRecord::Migration[5.1]
  def change
    create_table :leads, id: :uuid do |t|
      t.string :name
      t.string :company
      t.string :email
      t.string :mobile
      t.string :message
      t.string :purpose
      t.string :source
      t.timestamps
    end
  end
end
