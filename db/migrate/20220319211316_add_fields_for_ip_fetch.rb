class AddFieldsForIpFetch < ActiveRecord::Migration[6.1]
  def change
    add_column :sessions, :ip_response_code, :string
    add_column :sessions, :ip_response_body, :string
    add_column :sessions, :ip_request_duration, :integer
  end
end
