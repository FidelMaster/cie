require 'test_helper'

class Registry::EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registry_event = registry_events(:one)
  end

  test "should get index" do
    get registry_events_url
    assert_response :success
  end

  test "should get new" do
    get new_registry_event_url
    assert_response :success
  end

  test "should create registry_event" do
    assert_difference('Registry::Event.count') do
      post registry_events_url, params: { registry_event: { name: @registry_event.name, recurring: @registry_event.recurring, start_time: @registry_event.start_time } }
    end

    assert_redirected_to registry_event_url(Registry::Event.last)
  end

  test "should show registry_event" do
    get registry_event_url(@registry_event)
    assert_response :success
  end

  test "should get edit" do
    get edit_registry_event_url(@registry_event)
    assert_response :success
  end

  test "should update registry_event" do
    patch registry_event_url(@registry_event), params: { registry_event: { name: @registry_event.name, recurring: @registry_event.recurring, start_time: @registry_event.start_time } }
    assert_redirected_to registry_event_url(@registry_event)
  end

  test "should destroy registry_event" do
    assert_difference('Registry::Event.count', -1) do
      delete registry_event_url(@registry_event)
    end

    assert_redirected_to registry_events_url
  end
end
