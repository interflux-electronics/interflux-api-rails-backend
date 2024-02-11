class CreatePageViews < ActiveRecord::Migration[6.1]
  def change
    create_table :page_views, id: :uuid do |t|
      t.string :path

      t.uuid :browser_session_id

      t.timestamps
    end
  end
end
