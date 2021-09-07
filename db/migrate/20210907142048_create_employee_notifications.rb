class CreateEmployeeNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :employee_notifications do |t|
      t.references :employee,null: false,foreign_key: true
      t.references :issue,null: false,foreign_key:true
      t.string :content
      t.timestamps
    end
  end
end