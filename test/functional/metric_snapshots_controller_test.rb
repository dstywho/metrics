require 'test_helper'

class MetricSnapshotsControllerTest < ActionController::TestCase
  setup do
    @metric_snapshot = metric_snapshots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:metric_snapshots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create metric_snapshot" do
    assert_difference('MetricSnapshot.count') do
      post :create, :metric_snapshot => @metric_snapshot.attributes
    end

    assert_redirected_to metric_snapshot_path(assigns(:metric_snapshot))
  end

  test "should show metric_snapshot" do
    get :show, :id => @metric_snapshot.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @metric_snapshot.to_param
    assert_response :success
  end

  test "should update metric_snapshot" do
    put :update, :id => @metric_snapshot.to_param, :metric_snapshot => @metric_snapshot.attributes
    assert_redirected_to metric_snapshot_path(assigns(:metric_snapshot))
  end

  test "should destroy metric_snapshot" do
    assert_difference('MetricSnapshot.count', -1) do
      delete :destroy, :id => @metric_snapshot.to_param
    end

    assert_redirected_to metric_snapshots_path
  end
end
