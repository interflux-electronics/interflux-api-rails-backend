class CreateEmailAttempt < ActiveRecord::Migration[6.1]
  def change
    create_table :email_attempts, id: :uuid do |t|
      t.references :created_by, polymorphic: true, type: :uuid

      t.string :from
      t.string :to
      t.string :cc
      t.string :bcc
      t.string :reply_to

      t.integer :provider

      t.string :postmark_stream
      t.string :postmark_template_alias
      t.jsonb :postmark_template_model, default: {}

      # When storing JSONB
      # https://dev.to/kputra/rails-postgresql-jsonb-part-1-4ibg
      t.jsonb :response_body, default: {}
      t.integer :response_status
      t.boolean :delivered

      t.timestamps
    end

    add_index :email_attempts, :response_body, using: :gin
  end
end
