require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should get create" do
    post users_url, params: { user: { name: "Test User", email: "test@example.com", password: "securepassword" } }
    assert_response :success # Or :redirect, depending on your controller action
  end
end
