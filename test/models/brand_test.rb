require "test_helper"

class BrandTest< ActiveSupport::TestCase

  def setup
    @brand=Brand.new(name:"Test Brand")
  end

  test "brand is valid" do
    assert @brand.valid?
  end

  test "brand name should not be empty" do 
    @brand.name=""
    assert_not @brand.valid?
  end

  test "brand name should be unique" do
    duplicate_brand=@brand.dup
    @brand.save
    assert_not duplicate_brand.valid?
  end

end