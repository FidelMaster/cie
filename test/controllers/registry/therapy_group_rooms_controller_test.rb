require 'test_helper'

class Registry::TherapyGroupRoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registry_therapy_group_room = registry_therapy_group_rooms(:one)
  end

  test "should get index" do
    get registry_therapy_group_rooms_url
    assert_response :success
  end

  test "should get new" do
    get new_registry_therapy_group_room_url
    assert_response :success
  end

  test "should create registry_therapy_group_room" do
    assert_difference('Registry::TherapyGroupRoom.count') do
      post registry_therapy_group_rooms_url, params: { registry_therapy_group_room: { registry_therapy_group_id: @registry_therapy_group_room.registry_therapy_group_id, registry_therapy_room_id: @registry_therapy_group_room.registry_therapy_room_id } }
    end

    assert_redirected_to registry_therapy_group_room_url(Registry::TherapyGroupRoom.last)
  end

  test "should show registry_therapy_group_room" do
    get registry_therapy_group_room_url(@registry_therapy_group_room)
    assert_response :success
  end

  test "should get edit" do
    get edit_registry_therapy_group_room_url(@registry_therapy_group_room)
    assert_response :success
  end

  test "should update registry_therapy_group_room" do
    patch registry_therapy_group_room_url(@registry_therapy_group_room), params: { registry_therapy_group_room: { registry_therapy_group_id: @registry_therapy_group_room.registry_therapy_group_id, registry_therapy_room_id: @registry_therapy_group_room.registry_therapy_room_id } }
    assert_redirected_to registry_therapy_group_room_url(@registry_therapy_group_room)
  end

  test "should destroy registry_therapy_group_room" do
    assert_difference('Registry::TherapyGroupRoom.count', -1) do
      delete registry_therapy_group_room_url(@registry_therapy_group_room)
    end

    assert_redirected_to registry_therapy_group_rooms_url
  end
end
