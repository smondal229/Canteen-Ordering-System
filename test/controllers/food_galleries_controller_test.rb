require 'test_helper'

class FoodGalleriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get food_galleries_index_url
    assert_response :success
  end

end
