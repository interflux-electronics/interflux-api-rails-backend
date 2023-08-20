class AddConversionFlagsToImages < ActiveRecord::Migration[6.1]
  def change
    add_column :images, :user_id, :uuid
    add_column :images, :original, :string
    add_column :images, :converting, :boolean
    add_column :images, :conversion_error_log, :string
  end
end
