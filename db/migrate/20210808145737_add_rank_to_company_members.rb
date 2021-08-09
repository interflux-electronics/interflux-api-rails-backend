class AddRankToCompanyMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :company_members, :rank_among_companies, :integer
    add_column :company_members, :rank_among_members, :integer
  end
end
