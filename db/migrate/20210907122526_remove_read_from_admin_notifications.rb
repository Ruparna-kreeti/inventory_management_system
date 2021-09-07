class RemoveReadFromAdminNotifications < ActiveRecord::Migration[6.1]
  def change
    remove_column :admin_notifications, :read, :boolean
  end
end
