class AddWebsiteToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :website, :string
  end
end
