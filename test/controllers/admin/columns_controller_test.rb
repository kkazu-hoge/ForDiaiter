require "test_helper"

class Admin::ColumnsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_columns_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_columns_edit_url
    assert_response :success
  end

  test "should get create" do
    get admin_columns_create_url
    assert_response :success
  end

  test "should get update" do
    get admin_columns_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_columns_destroy_url
    assert_response :success
  end
end
