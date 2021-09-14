# frozen_string_literal: true

# notification model for admin
class AdminNotification < ApplicationRecord
  belongs_to :user
  belongs_to :storage

  default_scope { order('created_at DESC') }
end
