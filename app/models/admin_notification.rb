class AdminNotification < ApplicationRecord
  belongs_to :user
  belongs_to :storage
end