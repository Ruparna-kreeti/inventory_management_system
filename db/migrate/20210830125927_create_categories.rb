# frozen_string_literal: true

# migration for creating categories table
class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false, unique: true, index: true
      t.timestamps
    end
  end
end
