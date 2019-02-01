class AddIpMetaToLead < ActiveRecord::Migration[5.1]
  def change
    add_column :leads, :ip_country_id, :uuid
    add_column :leads, :ip_region, :text
    add_column :leads, :ip_city, :text
    add_column :leads, :ip, :text
  end
end
