class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions, id: :uuid do |t|
      t.string :href
      t.string :referrer
      t.string :ip
      t.string :ip_country_id
      t.string :ip_timezone
      t.string :ip_isp
      t.string :browser_app
      t.string :browser_width
      t.string :browser_height
      t.string :browser_languages

      t.uuid :user_id

      t.boolean :is_interflux_member, default: false

      t.timestamps
    end
  end
end
