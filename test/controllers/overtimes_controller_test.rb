require 'test_helper'

class OvertimesControllerTest < ActionController::TestCase
  setup do
    @overtime = overtimes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:overtimes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create overtime" do
    assert_difference('Overtime.count') do
      post :create, overtime: { approve: @overtime.approve, content: @overtime.content, duration: @overtime.duration, issue: @overtime.issue, project_id: @overtime.project_id, start_at: @overtime.start_at, user_id: @overtime.user_id }
    end

    assert_redirected_to overtime_path(assigns(:overtime))
  end

  test "should show overtime" do
    get :show, id: @overtime
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @overtime
    assert_response :success
  end

  test "should update overtime" do
    patch :update, id: @overtime, overtime: { approve: @overtime.approve, content: @overtime.content, duration: @overtime.duration, issue: @overtime.issue, project_id: @overtime.project_id, start_at: @overtime.start_at, user_id: @overtime.user_id }
    assert_redirected_to overtime_path(assigns(:overtime))
  end

  test "should destroy overtime" do
    assert_difference('Overtime.count', -1) do
      delete :destroy, id: @overtime
    end

    assert_redirected_to overtimes_path
  end
end
