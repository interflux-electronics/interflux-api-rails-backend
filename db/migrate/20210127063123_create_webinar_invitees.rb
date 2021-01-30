class CreateWebinarInvitees < ActiveRecord::Migration[5.1]
  def change
    create_table :webinar_invitees, id: :uuid do |t|
      t.uuid :webinar_id
      t.uuid :person_id

      t.timestamps
    end
  end
end
