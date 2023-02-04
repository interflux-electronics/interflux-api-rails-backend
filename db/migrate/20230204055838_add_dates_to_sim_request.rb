# Inspired from
# https://sergiodxa.com/articles/add-missing-created_at-and-updated_at-columns-in-rails
#
class AddDatesToSimRequest < ActiveRecord::Migration[6.1]
  def change
    add_timestamps(:simulation_requests, default: -> { 'CURRENT_TIMESTAMP' })
  end
end
