class AddTeamCountToCompanies < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :head_count, :integer, default: 1
  end
end
