require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get shifts" do
    get :shifts
    assert_response :success
  end

end
