require "test_helper"

class Public::PjEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_pj_events_show_url
    assert_response :success
  end

  test "should get new" do
    get public_pj_events_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_pj_events_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_pj_events_update_url
    assert_response :success
  end

  test "should get destroy" do
    get public_pj_events_destroy_url
    assert_response :success
  end
end
