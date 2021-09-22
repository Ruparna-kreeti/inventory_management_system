# frozen_string_literal: true

# migration for adding unique to section
class AddUniqueToSection < ActiveRecord::Migration[6.1]
  def change
    remove_index :sections, [:user_id]
    add_index :sections, :user_id, unique: true
  end
end
