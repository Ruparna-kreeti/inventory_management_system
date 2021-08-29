require "test_helper"

class UserTest< ActiveSupport::TestCase
    def setup
        @user=User.new(name:"Test User",email:"test@user.com",password:"password",password_confirmation:"password")
    end
    test "truth" do
        assert @user.valid?
    end
end