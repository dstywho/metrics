require 'test_helper'

class ReportDefinitionsControllerTest < ActionController::TestCase
  setup do
    @report_definition = report_definitions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:report_definitions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create report_definition" do
    assert_difference('ReportDefinition.count') do
      post :create, :report_definition => @report_definition.attributes
    end

    assert_redirected_to report_definition_path(assigns(:report_definition))
  end

  test "should show report_definition" do
    get :show, :id => @report_definition.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @report_definition.to_param
    assert_response :success
  end

  test "should update report_definition" do
    put :update, :id => @report_definition.to_param, :report_definition => @report_definition.attributes
    assert_redirected_to report_definition_path(assigns(:report_definition))
  end

  test "should destroy report_definition" do
    assert_difference('ReportDefinition.count', -1) do
      delete :destroy, :id => @report_definition.to_param
    end

    assert_redirected_to report_definitions_path
  end
end
