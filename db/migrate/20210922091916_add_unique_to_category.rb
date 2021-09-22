# frozen_string_literal: true

# migration for adding unique to category name
class AddUniqueToCategory < ActiveRecord::Migration[6.1]
  def change
    remove_index :categories, [:name]
    add_index :categories, :name, unique: true
  end
end
