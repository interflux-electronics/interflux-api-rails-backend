class UpdateCountry < ActiveRecord::Migration[5.1]
  def change
    rename_column :countries, :iso_3161_1_alpha_2_code, :two_letter_code
    rename_column :countries, :iso_3161_1_alpha_3_code, :three_letter_code
    rename_column :countries, :iso_3161_1_numeric_code, :numeric_code
  end
end
