require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get index path" do
    get users_path
    assert_response :success
  end

  test "should get new path" do
    get new_user_path
    assert_response :success
  end

end
