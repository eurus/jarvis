require 'test_helper'

class ErrandsControllerTest < ActionController::TestCase
  setup do
    @errand = errands(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:errands)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create errand" do
    assert_difference('Errand.count') do
      post :create, errand: { check: @errand.check, content: @errand.content, end_at: @errand.end_at, fee: @errand.fee, issue: @errand.issue, location: @errand.location, project_id: @errand.project_id, start_at: @errand.start_at, user_id: @errand.user_id }
    end

    assert_redirected_to errand_path(assigns(:errand))
  end

  test "should show errand" do
    get :show, id: @errand
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @errand
    assert_response :success
  end

  test "should update errand" do
    patch :update, id: @errand, errand: { check: @errand.check, content: @errand.content, end_at: @errand.end_at, fee: @errand.fee, issue: @errand.issue, location: @errand.location, project_id: @errand.project_id, start_at: @errand.start_at, user_id: @errand.user_id }
    assert_redirected_to errand_path(assigns(:errand))
  end

  test "should destroy errand" do
    assert_difference('Errand.count', -1) do
      delete :destroy, id: @errand
    end

    assert_redirected_to errands_path
  end
end
