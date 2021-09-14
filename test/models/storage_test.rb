# frozen_string_literal: true

require 'test_helper'

class StorageTest < ActiveSupport::TestCase
  def setup
    @brand = Brand.new(id: 1, name: 'test brand')
    @category = Category.new(id: 1, name: 'test category')
    @brand.save
    @category.save
    @item = Item.new(brand_id: @brand.id, category_id: @category.id, name: 'test item', notes: 'test notes',
                     buffer_quantity: 1)
    @item.save
    @storage = Storage.new(item_id: @item.id, quantity: 1, procurement_date: '11/11/2020')
  end

  test 'storage is valid' do
    assert @storage.valid?
  end

  test 'item should be present' do
    @storage.item_id = nil
    assert_not @storage.valid?
  end

  test 'quantity should be present' do
    @storage.quantity = nil
    assert_not @storage.valid?
  end
end
