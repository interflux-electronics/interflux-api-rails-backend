class CreatePageViews < ActiveRecord::Migration[6.1]
  def change
    create_table :page_views, id: :uuid do |t|
      t.string :path

      t.timestamps
    end
  end
end
