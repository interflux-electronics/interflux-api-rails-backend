class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries, id: :uuid do |t|
      t.string :name
      t.string :native_name
      t.string :region
      t.string :subregion
      t.string :alpha_2_code
      t.string :alpha_3_code
      t.string :numeric_code
      t.string :flag
      t.string :latlng

      t.numeric :area
      t.numeric :population

      t.string :languages
      t.string :timezones
      t.string :currencies
      t.string :top_level_domains
      t.string :calling_codes

      t.timestamps
    end
  end
end
