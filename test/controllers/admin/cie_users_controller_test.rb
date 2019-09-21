require 'test_helper'

class Admin::CieUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_cie_user = admin_cie_users(:one)
  end

  test "should get index" do
    get admin_cie_users_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_cie_user_url
    assert_response :success
  end

  test "should create admin_cie_user" do
    assert_difference('Admin::CieUser.count') do
      post admin_cie_users_url, params: { admin_cie_user: {  } }
    end

    assert_redirected_to admin_cie_user_url(Admin::CieUser.last)
  end

  test "should show admin_cie_user" do
    get admin_cie_user_url(@admin_cie_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_cie_user_url(@admin_cie_user)
    assert_response :success
  end

  test "should update admin_cie_user" do
    patch admin_cie_user_url(@admin_cie_user), params: { admin_cie_user: {  } }
    assert_redirected_to admin_cie_user_url(@admin_cie_user)
  end

  test "should destroy admin_cie_user" do
    assert_difference('Admin::CieUser.count', -1) do
      delete admin_cie_user_url(@admin_cie_user)
    end

    assert_redirected_to admin_cie_users_url
  end
end
