# frozen_string_literal: true

# migration for employees users table
class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.string :email, null: false, unique: true, index: true
      t.boolean :status, null: false
      t.timestamps
    end
  end
end
