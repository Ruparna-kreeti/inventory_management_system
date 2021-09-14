# frozen_string_literal: true

# model for section of user
class Section < ApplicationRecord
  belongs_to :user, touch: true
end
