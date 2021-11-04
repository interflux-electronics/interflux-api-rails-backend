class RecreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos, id: :string, primary_key: 'path' do |t|
      t.string :variations
      t.string :title_public
      t.string :title_admin
      t.string :poster_url

      t.timestamps
    end
  end
end
