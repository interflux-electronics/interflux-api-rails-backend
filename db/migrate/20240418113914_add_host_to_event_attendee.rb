class AddHostToEventAttendee < ActiveRecord::Migration[6.1]
  def change
    add_column :event_attendees, :locale, :string
  end
end
