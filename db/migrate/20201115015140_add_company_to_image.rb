class AddCompanyToImage < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :company_id, :uuid
  end
end
