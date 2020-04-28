class RecreateLanguagesAndCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries, id: :string, primary_key: 'two_letter_code' do |t|
      t.string :name_english
      t.string :name_native

      # t.string :two_letter_code
      t.string :three_letter_code
      t.string :numeric_code

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

    create_table :languages, id: :string, primary_key: 'two_letter_code' do |t|
      t.string :name_english
      t.string :name_native

      # t.string :two_letter_code
      t.string :three_letter_code

      t.boolean :public, default: false

      t.timestamps
    end

    create_table :currencies, id: :string, primary_key: 'code' do |t|
      # t.string :code
      t.string :name
      t.string :symbol

      t.timestamps
    end
  end
end
