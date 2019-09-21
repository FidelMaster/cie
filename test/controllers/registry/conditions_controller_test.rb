require 'test_helper'

class Registry::ConditionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registry_condition = registry_conditions(:one)
  end

  test "should get index" do
    get registry_conditions_url
    assert_response :success
  end

  test "should get new" do
    get new_registry_condition_url
    assert_response :success
  end

  test "should create registry_condition" do
    assert_difference('Registry::Condition.count') do
      post registry_conditions_url, params: { registry_condition: { description: @registry_condition.description, name: @registry_condition.name } }
    end

    assert_redirected_to registry_condition_url(Registry::Condition.last)
  end

  test "should show registry_condition" do
    get registry_condition_url(@registry_condition)
    assert_response :success
  end

  test "should get edit" do
    get edit_registry_condition_url(@registry_condition)
    assert_response :success
  end

  test "should update registry_condition" do
    patch registry_condition_url(@registry_condition), params: { registry_condition: { description: @registry_condition.description, name: @registry_condition.name } }
    assert_redirected_to registry_condition_url(@registry_condition)
  end

  test "should destroy registry_condition" do
    assert_difference('Registry::Condition.count', -1) do
      delete registry_condition_url(@registry_condition)
    end

    assert_redirected_to registry_conditions_url
  end
end
