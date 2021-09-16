# frozen_string_literal: true

# notification model for admin
class AdminNotification < ApplicationRecord
  belongs_to :user
  belongs_to :storage

  scope :recent, -> { order('created_at DESC') }
end
