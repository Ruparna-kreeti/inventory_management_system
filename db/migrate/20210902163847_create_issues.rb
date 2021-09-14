# frozen_string_literal: true

# migration for creating issues table
class CreateIssues < ActiveRecord::Migration[6.1]
  def change
    create_table :issues do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.text :detail, null: false, limit: 260
      t.boolean :is_solved, null: false, default: false
      t.timestamps
    end
  end
end
