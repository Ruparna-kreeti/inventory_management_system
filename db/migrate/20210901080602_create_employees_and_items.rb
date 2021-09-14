# frozen_string_literal: true

# migration for creating employee item association table
class CreateEmployeesAndItems < ActiveRecord::Migration[6.1]
  def change
    create_table :employees_items do |t|
      t.belongs_to :employee, null: false
      t.belongs_to :item, null: false
      t.boolean :status, null: false, default: true
      t.timestamps
    end
  end
end
