class DropTranslationEvents < ActiveRecord::Migration[6.1]
  def change
    drop_table :translation_events
  end
end
