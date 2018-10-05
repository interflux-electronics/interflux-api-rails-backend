# This migration enables an extension of Postgress for allowing UUIDs.
# Inspired from: https://lab.io/articles/2017/04/13/uuids-rails-5-1/

class EnablePgcryptoExtension < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto'
  end
end
