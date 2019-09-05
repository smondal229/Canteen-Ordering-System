require 'test_helper'

class Chefs::MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get chefs_messages_new_url
    assert_response :success
  end

  test "should get index" do
    get chefs_messages_index_url
    assert_response :success
  end

end
