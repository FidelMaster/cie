require 'test_helper'

class Registry::LevelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registry_level = registry_levels(:one)
  end

  test "should get index" do
    get registry_levels_url
    assert_response :success
  end

  test "should get new" do
    get new_registry_level_url
    assert_response :success
  end

  test "should create registry_level" do
    assert_difference('Registry::Level.count') do
      post registry_levels_url, params: { registry_level: { description: @registry_level.description, name: @registry_level.name, registry_age_range_id: @registry_level.registry_age_range_id } }
    end

    assert_redirected_to registry_level_url(Registry::Level.last)
  end

  test "should show registry_level" do
    get registry_level_url(@registry_level)
    assert_response :success
  end

  test "should get edit" do
    get edit_registry_level_url(@registry_level)
    assert_response :success
  end

  test "should update registry_level" do
    patch registry_level_url(@registry_level), params: { registry_level: { description: @registry_level.description, name: @registry_level.name, registry_age_range_id: @registry_level.registry_age_range_id } }
    assert_redirected_to registry_level_url(@registry_level)
  end

  test "should destroy registry_level" do
    assert_difference('Registry::Level.count', -1) do
      delete registry_level_url(@registry_level)
    end

    assert_redirected_to registry_levels_url
  end
end
