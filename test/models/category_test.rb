# frozen_string_literal: true

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: 'test category')
  end

  test 'category is valid' do
    assert @category.valid?
  end

  test 'name is required' do
    @category.name = ''
    assert_not @category.valid?
  end

  test 'duplicate category not allowed' do
    duplicate_category = @category.dup
    @category.save
    assert_not duplicate_category.valid?
  end
end
