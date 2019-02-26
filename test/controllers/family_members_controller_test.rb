require 'test_helper'

class FamilyMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get family_members_new_url
    assert_response :success
  end

  test "should get edit" do
    get family_members_edit_url
    assert_response :success
  end

  test "should get show" do
    get family_members_show_url
    assert_response :success
  end

  test "should get index" do
    get family_members_index_url
    assert_response :success
  end

end
