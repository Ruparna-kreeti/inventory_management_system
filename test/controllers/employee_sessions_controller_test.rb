require "test_helper"

class EmployeeSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get employee_sessions_new_url
    assert_response :success
  end
end
