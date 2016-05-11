require 'test_helper'

class WeekliesControllerTest < ActionController::TestCase
  setup do
    @weekly = weeklies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weeklies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weekly" do
    assert_difference('Weekly.count') do
      post :create, weekly: { hope: @weekly.hope, sumary: @weekly.sumary, user_id: @weekly.user_id }
    end

    assert_redirected_to weekly_path(assigns(:weekly))
  end

  test "should show weekly" do
    get :show, id: @weekly
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weekly
    assert_response :success
  end

  test "should update weekly" do
    patch :update, id: @weekly, weekly: { hope: @weekly.hope, sumary: @weekly.sumary, user_id: @weekly.user_id }
    assert_redirected_to weekly_path(assigns(:weekly))
  end

  test "should destroy weekly" do
    assert_difference('Weekly.count', -1) do
      delete :destroy, id: @weekly
    end

    assert_redirected_to weeklies_path
  end
end
