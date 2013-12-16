require 'test_helper'

class PurchasesControllerTest < ActionController::TestCase
  setup do
    @purchase = purchases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase" do
    assert_difference('Purchase.count') do
      post :create, purchase: { added_by: @purchase.added_by, discount: @purchase.discount, modified_by: @purchase.modified_by, no_of_unit: @purchase.no_of_unit, total_price: @purchase.total_price, unit_price: @purchase.unit_price }
    end

    assert_redirected_to purchase_path(assigns(:purchase))
  end

  test "should show purchase" do
    get :show, id: @purchase
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @purchase
    assert_response :success
  end

  test "should update purchase" do
    patch :update, id: @purchase, purchase: { added_by: @purchase.added_by, discount: @purchase.discount, modified_by: @purchase.modified_by, no_of_unit: @purchase.no_of_unit, total_price: @purchase.total_price, unit_price: @purchase.unit_price }
    assert_redirected_to purchase_path(assigns(:purchase))
  end

  test "should destroy purchase" do
    assert_difference('Purchase.count', -1) do
      delete :destroy, id: @purchase
    end

    assert_redirected_to purchases_path
  end
end
