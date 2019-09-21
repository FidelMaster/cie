require 'test_helper'

class Admin::CieRolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_cie_role = admin_cie_roles(:one)
  end

  test "should get index" do
    get admin_cie_roles_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_cie_role_url
    assert_response :success
  end

  test "should create admin_cie_role" do
    assert_difference('Admin::CieRole.count') do
      post admin_cie_roles_url, params: { admin_cie_role: { name: @admin_cie_role.name } }
    end

    assert_redirected_to admin_cie_role_url(Admin::CieRole.last)
  end

  test "should show admin_cie_role" do
    get admin_cie_role_url(@admin_cie_role)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_cie_role_url(@admin_cie_role)
    assert_response :success
  end

  test "should update admin_cie_role" do
    patch admin_cie_role_url(@admin_cie_role), params: { admin_cie_role: { name: @admin_cie_role.name } }
    assert_redirected_to admin_cie_role_url(@admin_cie_role)
  end

  test "should destroy admin_cie_role" do
    assert_difference('Admin::CieRole.count', -1) do
      delete admin_cie_role_url(@admin_cie_role)
    end

    assert_redirected_to admin_cie_roles_url
  end
end
