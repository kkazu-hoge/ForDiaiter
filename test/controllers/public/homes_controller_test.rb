require "test_helper"

class Public::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get public_homes_top_url
    assert_response :success
  end

  test "should get home" do
    get public_homes_home_url
    assert_response :success
  end

  test "should get pj_alter" do
    get public_homes_pj_alter_url
    assert_response :success
  end
end
