# frozen_string_literal: true

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @brand = Brand.new(id: 1, name: 'test brand')
    @category = Category.new(id: 1, name: 'test category')
    @brand.save
    @category.save
    @item = Item.new(brand_id: @brand.id, category_id: @category.id, name: 'test item', notes: 'test notes',
                     buffer_quantity: 1)
  end

  test 'item is valid' do
    assert @item.valid?
  end

  test 'brand should be there' do
    @item.brand_id = nil
    assert_not @item.valid?
  end

  test 'category should be there' do
    @item.category_id = nil
    assert_not @item.valid?
  end

  test 'name should be there' do
    @item.name = ''
    assert_not @item.valid?
  end

  test 'notes should be there' do
    @item.notes = ''
    assert_not @item.valid?
  end

  test 'buffer_quantity should be there' do
    @item.buffer_quantity = nil
    assert_not @item.valid?
  end

  test 'duplicate item not allowed' do
    duplicate_item = @item.dup
    @item.save
    assert_not duplicate_item.valid?
  end
end
