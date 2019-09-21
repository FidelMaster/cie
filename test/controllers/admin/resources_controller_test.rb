require 'test_helper'

class Admin::ResourcesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_resource = admin_resources(:one)
  end

  test "should get index" do
    get admin_resources_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_resource_url
    assert_response :success
  end

  test "should create admin_resource" do
    assert_difference('Admin::Resource.count') do
      post admin_resources_url, params: { admin_resource: { admin_resource_type_id: @admin_resource.admin_resource_type_id, description: @admin_resource.description, model: @admin_resource.model, module: @admin_resource.module, name: @admin_resource.name } }
    end

    assert_redirected_to admin_resource_url(Admin::Resource.last)
  end

  test "should show admin_resource" do
    get admin_resource_url(@admin_resource)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_resource_url(@admin_resource)
    assert_response :success
  end

  test "should update admin_resource" do
    patch admin_resource_url(@admin_resource), params: { admin_resource: { admin_resource_type_id: @admin_resource.admin_resource_type_id, description: @admin_resource.description, model: @admin_resource.model, module: @admin_resource.module, name: @admin_resource.name } }
    assert_redirected_to admin_resource_url(@admin_resource)
  end

  test "should destroy admin_resource" do
    assert_difference('Admin::Resource.count', -1) do
      delete admin_resource_url(@admin_resource)
    end

    assert_redirected_to admin_resources_url
  end
end
