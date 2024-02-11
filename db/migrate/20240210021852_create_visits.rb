class CreateVisits < ActiveRecord::Migration[6.1]
  def change
    create_table :visits, id: :uuid do |t|
      t.string :host
      t.string :path
      t.string :referrer
      t.string :user_agent
      t.string :ip
      t.string :ip_isp
      t.string :ip_country_id

      t.integer :viewport_width
      t.integer :viewport_height

      t.boolean :is_interflux
      t.boolean :is_bot

      t.uuid :browser_session_id
      t.uuid :user_id

      t.datetime :first_seen
      t.datetime :last_seen

      t.timestamps
    end
  end
end
