class AdminNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_notifications do |t|
      t.references :user,null: false,foreign_key: true
      t.references :storage,null: false,foreign_key: true
      t.string :content
      t.string :priority
      t.boolean :read
      t.timestamps
    end
  end
end
