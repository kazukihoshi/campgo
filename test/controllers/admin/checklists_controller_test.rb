require "test_helper"

class Admin::ChecklistsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_checklists_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_checklists_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_checklists_edit_url
    assert_response :success
  end
end
