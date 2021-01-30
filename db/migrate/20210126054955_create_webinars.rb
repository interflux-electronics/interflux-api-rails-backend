class CreateWebinars < ActiveRecord::Migration[5.1]
  def change
    create_table :webinars, id: :uuid do |t|
      t.string :title
      t.string :topic
      t.string :audience
      t.string :url

      t.boolean :public, default: false

      # Had to increase the limit to 8 to allow larger integer such Unix timestamps, which are
      # milliseconds since 1970. Example: 1611660330000;
      t.integer :start_time, limit: 8
      t.integer :duration

      t.uuid :person_id

      t.timestamps
    end
  end
end
