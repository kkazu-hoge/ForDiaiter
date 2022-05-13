require "test_helper"

class Public::CallendersControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get public_callenders_edit_url
    assert_response :success
  end

  test "should get new" do
    get public_callenders_new_url
    assert_response :success
  end

  test "should get show" do
    get public_callenders_show_url
    assert_response :success
  end
end
