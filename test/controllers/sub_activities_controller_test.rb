require 'test_helper'

class SubActivitiesControllerTest < ActionController::TestCase
  setup do
    @sub_activity = sub_activities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sub_activities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sub_activity" do
    assert_difference('SubActivity.count') do
      post :create, sub_activity: { activity_id: @sub_activity.activity_id, title: @sub_activity.title }
    end

    assert_redirected_to sub_activity_path(assigns(:sub_activity))
  end

  test "should show sub_activity" do
    get :show, id: @sub_activity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sub_activity
    assert_response :success
  end

  test "should update sub_activity" do
    patch :update, id: @sub_activity, sub_activity: { activity_id: @sub_activity.activity_id, title: @sub_activity.title }
    assert_redirected_to sub_activity_path(assigns(:sub_activity))
  end

  test "should destroy sub_activity" do
    assert_difference('SubActivity.count', -1) do
      delete :destroy, id: @sub_activity
    end

    assert_redirected_to sub_activities_path
  end
end
