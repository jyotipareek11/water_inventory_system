require 'test_helper'

class ClientsControllerTest < ActionController::TestCase
  setup do
    @client = clients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client" do
    assert_difference('Client.count') do
      post :create, client: { added_by: @client.added_by, address1: @client.address1, address2: @client.address2, city: @client.city, country: @client.country, distributer_id: @client.distributer_id, email_id: @client.email_id, land_line_number: @client.land_line_number, mobile_no: @client.mobile_no, modified_by: @client.modified_by, name: @client.name, pin: @client.pin, state: @client.state }
    end

    assert_redirected_to client_path(assigns(:client))
  end

  test "should show client" do
    get :show, id: @client
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client
    assert_response :success
  end

  test "should update client" do
    patch :update, id: @client, client: { added_by: @client.added_by, address1: @client.address1, address2: @client.address2, city: @client.city, country: @client.country, distributer_id: @client.distributer_id, email_id: @client.email_id, land_line_number: @client.land_line_number, mobile_no: @client.mobile_no, modified_by: @client.modified_by, name: @client.name, pin: @client.pin, state: @client.state }
    assert_redirected_to client_path(assigns(:client))
  end

  test "should destroy client" do
    assert_difference('Client.count', -1) do
      delete :destroy, id: @client
    end

    assert_redirected_to clients_path
  end
end
