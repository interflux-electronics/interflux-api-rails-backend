class CreateServerSideRenders < ActiveRecord::Migration[6.1]
  def change
    create_table :server_side_renders, id: :uuid do |t|
      t.string :host
      t.string :path
      t.string :referrer
      t.string :user_agent
      t.string :ip

      t.uuid :visit_id

      t.timestamps
    end
  end
end
