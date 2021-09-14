# frozen_string_literal: true

# migration for adding google tokens to users table
class AddColumnToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :google_token, :string
    add_column :users, :google_refresh_token, :string
  end
end
