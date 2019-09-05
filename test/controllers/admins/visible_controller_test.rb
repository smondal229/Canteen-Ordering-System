require 'test_helper'

class Admins::VisibleControllerTest < ActionDispatch::IntegrationTest
  test "should get employee_order_notification" do
    get admins_visible_employee_order_notification_url
    assert_response :success
  end

  test "should get chef_order_notification" do
    get admins_visible_chef_order_notification_url
    assert_response :success
  end

end
