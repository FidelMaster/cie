require 'test_helper'

class Registry::ReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registry_report = registry_reports(:one)
  end

  test "should get index" do
    get registry_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_registry_report_url
    assert_response :success
  end

  test "should create registry_report" do
    assert_difference('Registry::Report.count') do
      post registry_reports_url, params: { registry_report: {  } }
    end

    assert_redirected_to registry_report_url(Registry::Report.last)
  end

  test "should show registry_report" do
    get registry_report_url(@registry_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_registry_report_url(@registry_report)
    assert_response :success
  end

  test "should update registry_report" do
    patch registry_report_url(@registry_report), params: { registry_report: {  } }
    assert_redirected_to registry_report_url(@registry_report)
  end

  test "should destroy registry_report" do
    assert_difference('Registry::Report.count', -1) do
      delete registry_report_url(@registry_report)
    end

    assert_redirected_to registry_reports_url
  end
end
