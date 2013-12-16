require 'test_helper'

class LocationsControllerTest < ActionController::TestCase
  setup do
    @location = locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create location" do
    assert_difference('Location.count') do
      post :create, location: { added_by: @location.added_by, added_date: @location.added_date, address1: @location.address1, address2: @location.address2, city: @location.city, country: @location.country, modified_by: @location.modified_by, modified_date: @location.modified_date, name: @location.name, state: @location.state }
    end

    assert_redirected_to location_path(assigns(:location))
  end

  test "should show location" do
    get :show, id: @location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @location
    assert_response :success
  end

  test "should update location" do
    patch :update, id: @location, location: { added_by: @location.added_by, added_date: @location.added_date, address1: @location.address1, address2: @location.address2, city: @location.city, country: @location.country, modified_by: @location.modified_by, modified_date: @location.modified_date, name: @location.name, state: @location.state }
    assert_redirected_to location_path(assigns(:location))
  end

  test "should destroy location" do
    assert_difference('Location.count', -1) do
      delete :destroy, id: @location
    end

    assert_redirected_to locations_path
  end
end
