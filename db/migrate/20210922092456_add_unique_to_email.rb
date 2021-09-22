# frozen_string_literal: true

# migration for adding unique to email
class AddUniqueToEmail < ActiveRecord::Migration[6.1]
  def change
    remove_index :employees, [:email]
    add_index :employees, :email, unique: true
  end
end
