require 'test_helper'

class AuthControllerTest < ActionDispatch::IntegrationTest
  test "should get facebook" do
    get auth_facebook_url
    assert_response :success
  end

end
