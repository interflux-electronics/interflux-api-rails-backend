class AddArticleBody < ActiveRecord::Migration[5.1]
  def change
    remove_index :articles, :person_id
    remove_column :articles, :person_id

    add_column :articles, :body, :text
    add_column :articles, :date, :date
  end
end
