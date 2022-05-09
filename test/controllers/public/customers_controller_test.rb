require "test_helper"

class Public::CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_customers_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_customers_edit_url
    assert_response :success
  end

  test "should get edit_mail_address" do
    get public_customers_edit_mail_address_url
    assert_response :success
  end

  test "should get edit_password" do
    get public_customers_edit_password_url
    assert_response :success
  end

  test "should get edit_physical_info" do
    get public_customers_edit_physical_info_url
    assert_response :success
  end

  test "should get update" do
    get public_customers_update_url
    assert_response :success
  end

  test "should get update_mail_address" do
    get public_customers_update_mail_address_url
    assert_response :success
  end

  test "should get update_password" do
    get public_customers_update_password_url
    assert_response :success
  end

  test "should get update_physical_info" do
    get public_customers_update_physical_info_url
    assert_response :success
  end

  test "should get unsubscribe" do
    get public_customers_unsubscribe_url
    assert_response :success
  end

  test "should get defection" do
    get public_customers_defection_url
    assert_response :success
  end
end
