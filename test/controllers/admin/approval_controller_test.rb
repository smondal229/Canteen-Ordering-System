require 'test_helper'

class Admin::ApprovalControllerTest < ActionDispatch::IntegrationTest
  test "should get employee_approve" do
    get admin_approval_employee_approve_url
    assert_response :success
  end

  test "should get chef_approve" do
    get admin_approval_chef_approve_url
    assert_response :success
  end

end
