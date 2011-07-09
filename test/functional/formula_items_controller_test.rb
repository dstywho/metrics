require 'test_helper'

class FormulaItemsControllerTest < ActionController::TestCase
  setup do
    @formula_item = formula_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:formula_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create formula_item" do
    assert_difference('FormulaItem.count') do
      post :create, :formula_item => @formula_item.attributes
    end

    assert_redirected_to formula_item_path(assigns(:formula_item))
  end

  test "should show formula_item" do
    get :show, :id => @formula_item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @formula_item.to_param
    assert_response :success
  end

  test "should update formula_item" do
    put :update, :id => @formula_item.to_param, :formula_item => @formula_item.attributes
    assert_redirected_to formula_item_path(assigns(:formula_item))
  end

  test "should destroy formula_item" do
    assert_difference('FormulaItem.count', -1) do
      delete :destroy, :id => @formula_item.to_param
    end

    assert_redirected_to formula_items_path
  end
end
