class AddRankToUse < ActiveRecord::Migration[5.1]
  def change
    add_column :uses, :rank, :integer
  end
end
