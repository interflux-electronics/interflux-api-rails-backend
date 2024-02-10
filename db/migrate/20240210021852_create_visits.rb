class CreateVisits < ActiveRecord::Migration[6.1]
  def change
    create_table :visits, id: :uuid do |t|
      t.string :host
      t.string :referrer
      t.string :user_agent
      t.string :ip
      t.string :ip_isp
      t.string :ip_country_id

      t.integer :viewport_width
      t.integer :viewport_height

      t.uuid :user_id

      t.boolean :is_interflux
      t.boolean :is_bot

      t.timestamps
    end
  end
end
