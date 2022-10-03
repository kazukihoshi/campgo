require "test_helper"

class Public::CampsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_camps_new_url
    assert_response :success
  end

  test "should get show" do
    get public_camps_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_camps_edit_url
    assert_response :success
  end
end
