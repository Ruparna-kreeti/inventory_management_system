require "test_helper"

class UserTest< ActiveSupport::TestCase
    def setup
        @user=User.new(name:"Test User",email:"test@user.com",password:"password",password_confirmation:"password")
    end

    test "user is valid" do
        assert @user.valid?
    end

    test "name is required" do
        @user.name=""
        assert_not @user.valid?
    end

    test "email is required" do
        @user.email=""
        assert_not @user.valid?
    end

    test "user should be unique" do
      duplicate_user=@user.dup 
      @user.save
      assert_not duplicate_user.valid?
    end

    test "password cant be blank" do
        @user.password=@user.password_confirmation=" "*6
        assert_not @user.valid?
    end

    test "password must be minimum 6" do
        @user.password=@user.password_confirmation="a"*5
        assert_not @user.valid?
    end

    test "default admin is false" do
        assert !@user.admin?
    end

end