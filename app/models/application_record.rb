# frozen_string_literal: true

# default model
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
