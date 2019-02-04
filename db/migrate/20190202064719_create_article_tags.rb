class CreateArticleTags < ActiveRecord::Migration[5.1]
  def change
    create_table :article_tags, id: :uuid do |t|
      t.uuid :article_id
      t.uuid :tag_id

      t.timestamps
    end

    add_index :article_tags, :article_id
    add_index :article_tags, :tag_id
  end
end
