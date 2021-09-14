# frozen_string_literal: true

# migration for adding index to brand is and category id
class AddIndexToItem < ActiveRecord::Migration[6.1]
  def change
    add_index :items, %i[brand_id name category_id], unique: true
  end
end
