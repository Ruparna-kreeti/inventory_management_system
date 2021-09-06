class Section < ApplicationRecord
  belongs_to :user,touch: true
end