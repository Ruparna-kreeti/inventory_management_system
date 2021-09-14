# frozen_string_literal: true

# migration for removing read column fron admin notifications
class RemoveReadFromAdminNotifications < ActiveRecord::Migration[6.1]
  def change
    remove_column :admin_notifications, :read, :boolean
  end
end
