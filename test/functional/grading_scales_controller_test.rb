require 'test_helper'

class GradingScalesControllerTest < ActionController::TestCase
  setup do
    @grading_scale = grading_scales(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grading_scales)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grading_scale" do
    assert_difference('GradingScale.count') do
      post :create, :grading_scale => @grading_scale.attributes
    end

    assert_redirected_to grading_scale_path(assigns(:grading_scale))
  end

  test "should show grading_scale" do
    get :show, :id => @grading_scale.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @grading_scale.to_param
    assert_response :success
  end

  test "should update grading_scale" do
    put :update, :id => @grading_scale.to_param, :grading_scale => @grading_scale.attributes
    assert_redirected_to grading_scale_path(assigns(:grading_scale))
  end

  test "should destroy grading_scale" do
    assert_difference('GradingScale.count', -1) do
      delete :destroy, :id => @grading_scale.to_param
    end

    assert_redirected_to grading_scales_path
  end
end
