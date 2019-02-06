class CreateCountryLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :country_languages, id: :uuid do |t|
      t.uuid :country_id
      t.uuid :language_id

      t.timestamps
    end

    add_index :country_languages, :country_id
    add_index :country_languages, :language_id
  end
end
