require "test_helper"

class EmployeeTest< ActiveSupport::TestCase

  def setup
    @employee=Employee.new(name:"Test Employee",email:"test@email.com",status:true)
  end

  test "employee is valid" do
    assert @employee.valid?
  end

  test "employee name should be present" do
    @employee.name=" "
    assert_not @employee.valid?
  end

  test "employee email should be present" do
    @employee.email=" "
    assert_not @employee.valid?
  end

  test "employee should be unqiue" do
    duplicate_employee=@employee.dup
    @employee.save
    assert_not duplicate_employee.valid?
  end

  test "status should be present" do
    @employee.status=nil
    assert_not @employee.valid?
  end

  test "get status will give respective value" do
    assert @employee.get_status === "Active" 
  end

end