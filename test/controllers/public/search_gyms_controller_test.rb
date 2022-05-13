require "test_helper"

class Public::SearchGymsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_search_gyms_index_url
    assert_response :success
  end

  test "should get search" do
    get public_search_gyms_search_url
    assert_response :success
  end
end
