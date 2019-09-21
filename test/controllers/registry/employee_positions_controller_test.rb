require 'test_helper'

class Registry::EmployeePositionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registry_employee_position = registry_employee_positions(:one)
  end

  test "should get index" do
    get registry_employee_positions_url
    assert_response :success
  end

  test "should get new" do
    get new_registry_employee_position_url
    assert_response :success
  end

  test "should create registry_employee_position" do
    assert_difference('Registry::EmployeePosition.count') do
      post registry_employee_positions_url, params: { registry_employee_position: { description: @registry_employee_position.description, name: @registry_employee_position.name } }
    end

    assert_redirected_to registry_employee_position_url(Registry::EmployeePosition.last)
  end

  test "should show registry_employee_position" do
    get registry_employee_position_url(@registry_employee_position)
    assert_response :success
  end

  test "should get edit" do
    get edit_registry_employee_position_url(@registry_employee_position)
    assert_response :success
  end

  test "should update registry_employee_position" do
    patch registry_employee_position_url(@registry_employee_position), params: { registry_employee_position: { description: @registry_employee_position.description, name: @registry_employee_position.name } }
    assert_redirected_to registry_employee_position_url(@registry_employee_position)
  end

  test "should destroy registry_employee_position" do
    assert_difference('Registry::EmployeePosition.count', -1) do
      delete registry_employee_position_url(@registry_employee_position)
    end

    assert_redirected_to registry_employee_positions_url
  end
end
