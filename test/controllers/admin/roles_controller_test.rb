require 'test_helper'

class Admin::RolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_role = admin_roles(:one)
  end

  test "should get index" do
    get admin_roles_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_role_url
    assert_response :success
  end

  test "should create admin_role" do
    assert_difference('Admin::Role.count') do
      post admin_roles_url, params: { admin_role: { description: @admin_role.description, name: @admin_role.name } }
    end

    assert_redirected_to admin_role_url(Admin::Role.last)
  end

  test "should show admin_role" do
    get admin_role_url(@admin_role)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_role_url(@admin_role)
    assert_response :success
  end

  test "should update admin_role" do
    patch admin_role_url(@admin_role), params: { admin_role: { description: @admin_role.description, name: @admin_role.name } }
    assert_redirected_to admin_role_url(@admin_role)
  end

  test "should destroy admin_role" do
    assert_difference('Admin::Role.count', -1) do
      delete admin_role_url(@admin_role)
    end

    assert_redirected_to admin_roles_url
  end
end
