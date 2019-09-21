require 'test_helper'

class Registry::EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registry_employee = registry_employees(:one)
  end

  test "should get index" do
    get registry_employees_url
    assert_response :success
  end

  test "should get new" do
    get new_registry_employee_url
    assert_response :success
  end

  test "should create registry_employee" do
    assert_difference('Registry::Employee.count') do
      post registry_employees_url, params: { registry_employee: { active: @registry_employee.active, avatar: @registry_employee.avatar, birth_date: @registry_employee.birth_date, first_name: @registry_employee.first_name, last_name: @registry_employee.last_name, registry_employee_position_id: @registry_employee.registry_employee_position_id, start_date: @registry_employee.start_date } }
    end

    assert_redirected_to registry_employee_url(Registry::Employee.last)
  end

  test "should show registry_employee" do
    get registry_employee_url(@registry_employee)
    assert_response :success
  end

  test "should get edit" do
    get edit_registry_employee_url(@registry_employee)
    assert_response :success
  end

  test "should update registry_employee" do
    patch registry_employee_url(@registry_employee), params: { registry_employee: { active: @registry_employee.active, avatar: @registry_employee.avatar, birth_date: @registry_employee.birth_date, first_name: @registry_employee.first_name, last_name: @registry_employee.last_name, registry_employee_position_id: @registry_employee.registry_employee_position_id, start_date: @registry_employee.start_date } }
    assert_redirected_to registry_employee_url(@registry_employee)
  end

  test "should destroy registry_employee" do
    assert_difference('Registry::Employee.count', -1) do
      delete registry_employee_url(@registry_employee)
    end

    assert_redirected_to registry_employees_url
  end
end
