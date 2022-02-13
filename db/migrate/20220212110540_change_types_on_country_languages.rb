class ChangeTypesOnCountryLanguages < ActiveRecord::Migration[6.1]
  def change
    change_column :country_languages, :country_id, :string
    change_column :country_languages, :language_id, :string
  end
end
