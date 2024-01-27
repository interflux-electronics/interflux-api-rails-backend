class CreateVisits < ActiveRecord::Migration[6.1]
  def change
    create_table :visits, id: :uuid do |t|
      t.string :ip
      t.string :ip_isp
      t.string :ip_country
      t.string :user_agent
      t.string :user_agent_ssr
      t.string :browser_width
      t.string :browser_height
      t.datetime :start_time
      t.datetime :end_time
      t.uuid :user_id
    end
  end
end
