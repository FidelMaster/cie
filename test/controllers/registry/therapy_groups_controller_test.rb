require 'test_helper'

class Registry::TherapyGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registry_therapy_group = registry_therapy_groups(:one)
  end

  test "should get index" do
    get registry_therapy_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_registry_therapy_group_url
    assert_response :success
  end

  test "should create registry_therapy_group" do
    assert_difference('Registry::TherapyGroup.count') do
      post registry_therapy_groups_url, params: { registry_therapy_group: { description: @registry_therapy_group.description, name: @registry_therapy_group.name } }
    end

    assert_redirected_to registry_therapy_group_url(Registry::TherapyGroup.last)
  end

  test "should show registry_therapy_group" do
    get registry_therapy_group_url(@registry_therapy_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_registry_therapy_group_url(@registry_therapy_group)
    assert_response :success
  end

  test "should update registry_therapy_group" do
    patch registry_therapy_group_url(@registry_therapy_group), params: { registry_therapy_group: { description: @registry_therapy_group.description, name: @registry_therapy_group.name } }
    assert_redirected_to registry_therapy_group_url(@registry_therapy_group)
  end

  test "should destroy registry_therapy_group" do
    assert_difference('Registry::TherapyGroup.count', -1) do
      delete registry_therapy_group_url(@registry_therapy_group)
    end

    assert_redirected_to registry_therapy_groups_url
  end
end
