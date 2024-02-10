class CreateClientSideRenders < ActiveRecord::Migration[6.1]
  def change
    create_table :client_side_renders, id: :uuid do |t|
      t.string :host
      t.string :referrer
      t.string :user_agent
      t.string :ip

      t.integer :viewport_width
      t.integer :viewport_height

      t.uuid :visit_id
      t.uuid :user_id

      t.timestamps
    end
  end
end
