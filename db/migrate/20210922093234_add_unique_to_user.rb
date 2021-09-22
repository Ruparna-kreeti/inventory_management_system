# frozen_string_literal: true

# migration for adding unique to user
class AddUniqueToUser < ActiveRecord::Migration[6.1]
  def change
    remove_index :users, [:email]
    add_index :users, :email, unique: true
  end
end
