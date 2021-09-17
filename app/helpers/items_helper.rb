# frozen_string_literal: true

# helper contains item and admin notification
module ItemsHelper
  def access_items
    @items = Item.includes(:brand, :category).all
  end

  def admin_notifications(item)
    @admins = User.where(admin: true)
    if item.storage.quantity < 1
      create_admin_notification @admins, item.storage, 'Check ASAP', 'high'
      flash[:danger] = 'Check your storage immediately'
    elsif item.storage.quantity < item.buffer_quantity
      create_admin_notification @admins, item.storage, 'Check at a prior date', 'medium'
      flash[:warning] = 'Check your storage before the item runs out!'
    end
  end

  def create_admin_notification(admins, storage, content, priority)
    admins.each do |admin|
      AdminNotification.create!(user: admin, storage: storage, content: content, priority: priority)
    end
  end
end
