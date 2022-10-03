require "test_helper"

class Public::ChecklistsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get public_checklists_edit_url
    assert_response :success
  end
end
