require 'test_helper'

class PlansControllerTest < ActionController::TestCase
  setup do
    @plan = plans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plan" do
    assert_difference('Plan.count') do
      post :create, plan: { cut: @plan.cut, description: @plan.description, end_at: @plan.end_at, start_at: @plan.start_at, status: @plan.status, title: @plan.title, user_id: @plan.user_id }
    end

    assert_redirected_to plan_path(assigns(:plan))
  end

  test "should show plan" do
    get :show, id: @plan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plan
    assert_response :success
  end

  test "should update plan" do
    patch :update, id: @plan, plan: { cut: @plan.cut, description: @plan.description, end_at: @plan.end_at, start_at: @plan.start_at, status: @plan.status, title: @plan.title, user_id: @plan.user_id }
    assert_redirected_to plan_path(assigns(:plan))
  end

  test "should destroy plan" do
    assert_difference('Plan.count', -1) do
      delete :destroy, id: @plan
    end

    assert_redirected_to plans_path
  end
end
