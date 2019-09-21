require 'test_helper'

class Registry::TherapyRoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registry_therapy_room = registry_therapy_rooms(:one)
  end

  test "should get index" do
    get registry_therapy_rooms_url
    assert_response :success
  end

  test "should get new" do
    get new_registry_therapy_room_url
    assert_response :success
  end

  test "should create registry_therapy_room" do
    assert_difference('Registry::TherapyRoom.count') do
      post registry_therapy_rooms_url, params: { registry_therapy_room: { capacity: @registry_therapy_room.capacity, description: @registry_therapy_room.description, name: @registry_therapy_room.name, registry_therapy_type_id: @registry_therapy_room.registry_therapy_type_id } }
    end

    assert_redirected_to registry_therapy_room_url(Registry::TherapyRoom.last)
  end

  test "should show registry_therapy_room" do
    get registry_therapy_room_url(@registry_therapy_room)
    assert_response :success
  end

  test "should get edit" do
    get edit_registry_therapy_room_url(@registry_therapy_room)
    assert_response :success
  end

  test "should update registry_therapy_room" do
    patch registry_therapy_room_url(@registry_therapy_room), params: { registry_therapy_room: { capacity: @registry_therapy_room.capacity, description: @registry_therapy_room.description, name: @registry_therapy_room.name, registry_therapy_type_id: @registry_therapy_room.registry_therapy_type_id } }
    assert_redirected_to registry_therapy_room_url(@registry_therapy_room)
  end

  test "should destroy registry_therapy_room" do
    assert_difference('Registry::TherapyRoom.count', -1) do
      delete registry_therapy_room_url(@registry_therapy_room)
    end

    assert_redirected_to registry_therapy_rooms_url
  end
end
