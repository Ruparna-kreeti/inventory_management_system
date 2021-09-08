require "test_helper"

class IssueTest< ActiveSupport::TestCase
  def setup
    @brand=Brand.new(id:1,name:"test brand")
    @category=Category.new(id:1,name:"test category")
    @brand.save
    @category.save
    @item=Item.new(brand_id:@brand.id,category_id:@category.id,name:"test item",notes:"test notes",buffer_quantity:1)
    @item.save
    @employee=Employee.new(name:"Test Employee",email:"test@email.com",status:true)
    @employee.save
    @issue=Issue.new(employee_id:@employee.id,item_id:@item.id,detail:"a"*200,is_solved:false)
  end

  test "issue is valid" do
    assert @issue.valid?
  end

  test "item should be present" do
    @issue.item_id=nil
    assert_not @issue.valid?
  end

  test "employee should be present" do
    @issue.employee_id=nil
    assert_not @issue.valid?
  end

  test "details shoulde be maximum 260" do
    @issue.detail="a"*261
    assert_not @issue.valid?
  end

end