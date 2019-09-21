require 'test_helper'

class Registry::DateEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registry_date_event = registry_date_events(:one)
  end

  test "should get index" do
    get registry_date_events_url
    assert_response :success
  end

  test "should get new" do
    get new_registry_date_event_url
    assert_response :success
  end

  test "should create registry_date_event" do
    assert_difference('Registry::DateEvent.count') do
      post registry_date_events_url, params: { registry_date_event: { color: @registry_date_event.color, description: @registry_date_event.description, end_time: @registry_date_event.end_time, name: @registry_date_event.name, start_time: @registry_date_event.start_time, type: @registry_date_event.type } }
    end

    assert_redirected_to registry_date_event_url(Registry::DateEvent.last)
  end

  test "should show registry_date_event" do
    get registry_date_event_url(@registry_date_event)
    assert_response :success
  end

  test "should get edit" do
    get edit_registry_date_event_url(@registry_date_event)
    assert_response :success
  end

  test "should update registry_date_event" do
    patch registry_date_event_url(@registry_date_event), params: { registry_date_event: { color: @registry_date_event.color, description: @registry_date_event.description, end_time: @registry_date_event.end_time, name: @registry_date_event.name, start_time: @registry_date_event.start_time, type: @registry_date_event.type } }
    assert_redirected_to registry_date_event_url(@registry_date_event)
  end

  test "should destroy registry_date_event" do
    assert_difference('Registry::DateEvent.count', -1) do
      delete registry_date_event_url(@registry_date_event)
    end

    assert_redirected_to registry_date_events_url
  end
end
