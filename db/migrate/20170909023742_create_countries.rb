# frozen_string_literal: true

class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries, &:timestamps
  end
end
