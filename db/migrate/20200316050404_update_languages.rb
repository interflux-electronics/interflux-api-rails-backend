class UpdateLanguages < ActiveRecord::Migration[5.1]
  def change
    rename_column :languages, :iso_639_1_code, :two_letter_code
    rename_column :languages, :iso_639_2_code, :three_letter_code
  end
end
