# In Postgress there is no performance difference between :text and :string,
# thus one should always opt for :text.
#
# Source:
# https://stackoverflow.com/questions/3354330/difference-between-string-and-text-in-rails
# https://www.postgresql.org/docs/current/datatype-character.html
#
class ConvertStringColumnsToText < ActiveRecord::Migration[5.1]
  def change
    change_column :leads, :name, :text
    change_column :leads, :company, :text
    change_column :leads, :email, :text
    change_column :leads, :mobile, :text
    change_column :leads, :message, :text
    change_column :leads, :purpose, :text
    change_column :leads, :source, :text
    change_column :countries, :name, :text
    change_column :countries, :native_name, :text
    change_column :countries, :region, :text
    change_column :countries, :subregion, :text
    change_column :countries, :alpha_2_code, :text
    change_column :countries, :alpha_3_code, :text
    change_column :countries, :numeric_code, :text
    change_column :countries, :flag, :text
    change_column :countries, :latlng, :text
    change_column :countries, :languages, :text
    change_column :countries, :timezones, :text
    change_column :countries, :currencies, :text
    change_column :countries, :top_level_domains, :text
    change_column :countries, :calling_codes, :text
  end
end
