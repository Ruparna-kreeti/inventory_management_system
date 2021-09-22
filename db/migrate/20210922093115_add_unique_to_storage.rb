# frozen_string_literal: true

# migration for adding unique to storage
class AddUniqueToStorage < ActiveRecord::Migration[6.1]
  def change
    remove_index :storages, [:item_id]
    add_index :storages, :item_id, unique: true
  end
end
