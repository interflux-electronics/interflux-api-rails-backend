class CreateLeads < ActiveRecord::Migration[5.1]
  def change
    create_table :leads, id: :uuid do |t|
      t.string :name
      t.string :company
      t.string :email
      t.string :mobile
      t.text :message
      t.string :purpose
      t.string :source
      t.string :ip_region
      t.string :ip_city
      t.string :ip

      t.uuid :country_id
      t.uuid :ip_country_id

      t.timestamps
    end

    add_index :leads, :country_id
    add_index :leads, :ip_country_id
  end
end
