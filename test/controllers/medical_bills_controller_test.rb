require 'test_helper'

class MedicalBillsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get medical_bills_index_url
    assert_response :success
  end

  test "should get show" do
    get medical_bills_show_url
    assert_response :success
  end

  test "should get new" do
    get medical_bills_new_url
    assert_response :success
  end

  test "should get edit" do
    get medical_bills_edit_url
    assert_response :success
  end

end
