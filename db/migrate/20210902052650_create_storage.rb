# frozen_string_literal: true

# migration for creating storage table
class CreateStorage < ActiveRecord::Migration[6.1]
  def change
    create_table :storages do |t|
      t.references :item, null: false, foreign_key: true, unique: true
      t.integer :quantity, null: false
      t.datetime :procurement_date, null: false
      t.timestamps
    end
  end
end
