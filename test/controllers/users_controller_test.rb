require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should get create" do
    post users_url, params: { user: { full_name: "Test User", email_address: "test@example.com", password: "securepassword" } }
    assert_response :redirect # :success or :redirect, depending on your controller action
    assert_redirected_to new_session_path
  end
end
