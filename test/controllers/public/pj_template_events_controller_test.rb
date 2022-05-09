require "test_helper"

class Public::PjTemplateEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_pj_template_events_new_url
    assert_response :success
  end

  test "should get create" do
    get public_pj_template_events_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_pj_template_events_destroy_url
    assert_response :success
  end

  test "should get pj_event_add_training" do
    get public_pj_template_events_pj_event_add_training_url
    assert_response :success
  end

  test "should get show_event" do
    get public_pj_template_events_show_event_url
    assert_response :success
  end
end
