require "test_helper"

class Public::TrainingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_trainings_index_url
    assert_response :success
  end

  test "should get show" do
    get public_trainings_show_url
    assert_response :success
  end
end
