class CreateWebinars < ActiveRecord::Migration[5.1]
  def change
    create_table :webinars, id: :uuid do |t|
      t.string :topic
      t.string :blurb
      t.string :url

      # Had to increase the limit to 8 to allow larger integer such Unix timestamps, which are
      # milliseconds since 1970. Example: 1611660330000;
      t.integer :start_time, limit: 8

      t.integer :duration
      t.boolean :public, default: false

      t.uuid :person_id

      t.timestamps
    end
  end
end
