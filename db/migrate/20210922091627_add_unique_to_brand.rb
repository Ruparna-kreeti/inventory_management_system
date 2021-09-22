# frozen_string_literal: true

# migration for adding unique to brand
class AddUniqueToBrand < ActiveRecord::Migration[6.1]
  def change
    remove_index :brands, [:name]
    add_index :brands, :name, unique: true
  end
end
