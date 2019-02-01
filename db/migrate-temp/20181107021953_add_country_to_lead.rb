class AddCountryToLead < ActiveRecord::Migration[5.1]
  def change
    add_column :leads, :country_id, :uuid
  end
end
