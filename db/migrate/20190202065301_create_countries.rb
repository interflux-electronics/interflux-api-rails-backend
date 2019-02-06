class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries, id: :uuid do |t|
      t.string :name_english
      t.string :name_native

      t.string :iso_3161_1_alpha_2_code
      t.string :iso_3161_1_alpha_3_code
      t.string :iso_3161_1_numeric_code

      t.string :region
      t.string :subregion
      t.decimal :latitude
      t.decimal :longitude
      t.integer :area
      t.integer :population
      t.string :flag_url

      t.string :timezones
      t.string :top_level_domains
      t.string :calling_codes

      t.timestamps
    end

    add_index :countries, :name_english, unique: true
    add_index :countries, :name_native, unique: true
    add_index :countries, :iso_3161_1_alpha_2_code, unique: true
    add_index :countries, :iso_3161_1_alpha_3_code, unique: true
    add_index :countries, :iso_3161_1_numeric_code, unique: true
  end
end
