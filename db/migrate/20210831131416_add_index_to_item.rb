class AddIndexToItem < ActiveRecord::Migration[6.1]
  def change
    add_index :items, [:brand_id, :name, :category_id], :unique => true
  end
end
