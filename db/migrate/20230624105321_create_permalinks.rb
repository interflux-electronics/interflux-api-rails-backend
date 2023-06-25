class CreatePermalinks < ActiveRecord::Migration[6.1]
  def change
    create_table :permalinks, id: :uuid do |t|
      t.string :slug
      t.string :redirect_to
      t.string :notes
    end
  end
end
