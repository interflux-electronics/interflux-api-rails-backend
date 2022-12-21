class CreateTranslationEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :translation_events, id: :uuid do |t|
      t.uuid :translation_id # the translation on which was made a change

      t.string :code # created | human-update | robot-update | source-update
      t.string :updated_by # the full name of the person who made the human update

      t.timestamps
    end
  end
end
