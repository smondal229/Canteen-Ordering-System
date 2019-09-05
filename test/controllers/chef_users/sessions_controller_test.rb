require 'test_helper'

class Chefs::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get chefs_sessions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get chefs_sessions_destroy_url
    assert_response :success
  end

end
