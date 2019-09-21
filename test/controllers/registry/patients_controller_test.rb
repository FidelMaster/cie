require 'test_helper'

class Registry::PatientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registry_patient = registry_patients(:one)
  end

  test "should get index" do
    get registry_patients_url
    assert_response :success
  end

  test "should get new" do
    get new_registry_patient_url
    assert_response :success
  end

  test "should create registry_patient" do
    assert_difference('Registry::Patient.count') do
      post registry_patients_url, params: { registry_patient: { birth_date: @registry_patient.birth_date, first_name: @registry_patient.first_name, gender: @registry_patient.gender, last_name: @registry_patient.last_name } }
    end

    assert_redirected_to registry_patient_url(Registry::Patient.last)
  end

  test "should show registry_patient" do
    get registry_patient_url(@registry_patient)
    assert_response :success
  end

  test "should get edit" do
    get edit_registry_patient_url(@registry_patient)
    assert_response :success
  end

  test "should update registry_patient" do
    patch registry_patient_url(@registry_patient), params: { registry_patient: { birth_date: @registry_patient.birth_date, first_name: @registry_patient.first_name, gender: @registry_patient.gender, last_name: @registry_patient.last_name } }
    assert_redirected_to registry_patient_url(@registry_patient)
  end

  test "should destroy registry_patient" do
    assert_difference('Registry::Patient.count', -1) do
      delete registry_patient_url(@registry_patient)
    end

    assert_redirected_to registry_patients_url
  end
end
