class AdminNotification < ApplicationRecord
  belongs_to :user
  belongs_to :storage

  default_scope{order('created_at DESC')}
  
end