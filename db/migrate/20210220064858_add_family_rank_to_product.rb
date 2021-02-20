class AddFamilyRankToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :rank_among_family, :integer
  end
end
