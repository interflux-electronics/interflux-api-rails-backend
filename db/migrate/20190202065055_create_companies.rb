class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies, id: :uuid do |t|
      t.string :slug
      t.string :name
      t.string :address
      t.string :email
      t.string :phone
      t.string :fax
      t.decimal :latitude
      t.decimal :longitude

      t.uuid :country_id

      t.timestamps
    end

    add_index :companies, :slug, unique: true
    add_index :companies, :name, unique: true
    add_index :companies, :country_id
  end
end
