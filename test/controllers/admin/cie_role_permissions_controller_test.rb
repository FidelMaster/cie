require 'test_helper'

class Admin::CieRolePermissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_cie_role_permission = admin_cie_role_permissions(:one)
  end

  test "should get index" do
    get admin_cie_role_permissions_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_cie_role_permission_url
    assert_response :success
  end

  test "should create admin_cie_role_permission" do
    assert_difference('Admin::CieRolePermission.count') do
      post admin_cie_role_permissions_url, params: { admin_cie_role_permission: { admin_action_id: @admin_cie_role_permission.admin_action_id, admin_resource_id: @admin_cie_role_permission.admin_resource_id, registry_cie_role_id: @admin_cie_role_permission.registry_cie_role_id } }
    end

    assert_redirected_to admin_cie_role_permission_url(Admin::CieRolePermission.last)
  end

  test "should show admin_cie_role_permission" do
    get admin_cie_role_permission_url(@admin_cie_role_permission)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_cie_role_permission_url(@admin_cie_role_permission)
    assert_response :success
  end

  test "should update admin_cie_role_permission" do
    patch admin_cie_role_permission_url(@admin_cie_role_permission), params: { admin_cie_role_permission: { admin_action_id: @admin_cie_role_permission.admin_action_id, admin_resource_id: @admin_cie_role_permission.admin_resource_id, registry_cie_role_id: @admin_cie_role_permission.registry_cie_role_id } }
    assert_redirected_to admin_cie_role_permission_url(@admin_cie_role_permission)
  end

  test "should destroy admin_cie_role_permission" do
    assert_difference('Admin::CieRolePermission.count', -1) do
      delete admin_cie_role_permission_url(@admin_cie_role_permission)
    end

    assert_redirected_to admin_cie_role_permissions_url
  end
end
