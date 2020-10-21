class CreateCdnFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :cdn_files, id: :uuid do |t|
      t.string :path

      t.timestamps
    end
  end
end
