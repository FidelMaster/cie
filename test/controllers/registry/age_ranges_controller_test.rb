require 'test_helper'

class Registry::AgeRangesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registry_age_range = registry_age_ranges(:one)
  end

  test "should get index" do
    get registry_age_ranges_url
    assert_response :success
  end

  test "should get new" do
    get new_registry_age_range_url
    assert_response :success
  end

  test "should create registry_age_range" do
    assert_difference('Registry::AgeRange.count') do
      post registry_age_ranges_url, params: { registry_age_range: { description: @registry_age_range.description, max_age: @registry_age_range.max_age, min_age: @registry_age_range.min_age, name: @registry_age_range.name } }
    end

    assert_redirected_to registry_age_range_url(Registry::AgeRange.last)
  end

  test "should show registry_age_range" do
    get registry_age_range_url(@registry_age_range)
    assert_response :success
  end

  test "should get edit" do
    get edit_registry_age_range_url(@registry_age_range)
    assert_response :success
  end

  test "should update registry_age_range" do
    patch registry_age_range_url(@registry_age_range), params: { registry_age_range: { description: @registry_age_range.description, max_age: @registry_age_range.max_age, min_age: @registry_age_range.min_age, name: @registry_age_range.name } }
    assert_redirected_to registry_age_range_url(@registry_age_range)
  end

  test "should destroy registry_age_range" do
    assert_difference('Registry::AgeRange.count', -1) do
      delete registry_age_range_url(@registry_age_range)
    end

    assert_redirected_to registry_age_ranges_url
  end
end
