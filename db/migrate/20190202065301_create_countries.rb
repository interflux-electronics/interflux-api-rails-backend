class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries, id: :uuid do |t|
      # t.string :slug
      t.string :name_english
      t.string :name_native
      t.string :alpha2_code
      t.string :alpha3_code
      t.string :numeric_code

      t.string :region
      t.string :subregion
      t.decimal :latitude
      t.decimal :longitude
      t.integer :area
      t.integer :population
      t.string :flag_url

      t.string :currencies
      t.string :timezones
      t.string :languages
      t.string :top_level_domains
      t.string :calling_codes

      t.timestamps
    end

    add_index :countries, :name_english, unique: true
    add_index :countries, :name_native, unique: true
    add_index :countries, :alpha2_code, unique: true
    add_index :countries, :alpha3_code, unique: true
    add_index :countries, :numeric_code, unique: true
  end
end
