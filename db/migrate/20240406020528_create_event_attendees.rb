class CreateEventAttendees < ActiveRecord::Migration[6.1]
  def change
    change_table :events, bulk: true do |t|
      t.column :has_registration_form, :boolean

      t.column :ask_first_name, :boolean
      t.column :ask_last_name, :boolean
      t.column :ask_role, :boolean
      t.column :ask_company, :boolean

      t.column :confirmation_email_subject, :string, default: 'See you soon at {event_name}!'
      t.column :confirmation_email_body, :string, default: 'Hello {first_name} {last_name},    We look forward seeing you at {event_name} on {event_date} in {event_location}.    Best regards,    The Interflux Electronics team'
      t.column :confirmation_email_bcc, :string, default: 's.teliszewski@interflux.com, jw@interflux.au'
    end

    change_table :permalinks, bulk: true do |t|
      t.column :event_id, :uuid
    end

    create_table :event_attendees, id: :uuid do |t|
      t.uuid :event_id
      t.uuid :person_id

      t.string :first_name
      t.string :last_name
      t.string :role
      t.string :company
      t.string :email

      t.timestamps
    end
  end
end
