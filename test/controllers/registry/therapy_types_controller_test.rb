require 'test_helper'

class Registry::TherapyTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registry_therapy_type = registry_therapy_types(:one)
  end

  test "should get index" do
    get registry_therapy_types_url
    assert_response :success
  end

  test "should get new" do
    get new_registry_therapy_type_url
    assert_response :success
  end

  test "should create registry_therapy_type" do
    assert_difference('Registry::TherapyType.count') do
      post registry_therapy_types_url, params: { registry_therapy_type: { description: @registry_therapy_type.description, name: @registry_therapy_type.name } }
    end

    assert_redirected_to registry_therapy_type_url(Registry::TherapyType.last)
  end

  test "should show registry_therapy_type" do
    get registry_therapy_type_url(@registry_therapy_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_registry_therapy_type_url(@registry_therapy_type)
    assert_response :success
  end

  test "should update registry_therapy_type" do
    patch registry_therapy_type_url(@registry_therapy_type), params: { registry_therapy_type: { description: @registry_therapy_type.description, name: @registry_therapy_type.name } }
    assert_redirected_to registry_therapy_type_url(@registry_therapy_type)
  end

  test "should destroy registry_therapy_type" do
    assert_difference('Registry::TherapyType.count', -1) do
      delete registry_therapy_type_url(@registry_therapy_type)
    end

    assert_redirected_to registry_therapy_types_url
  end
end
