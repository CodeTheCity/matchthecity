require 'test_helper'

class EffortRatingsControllerTest < ActionController::TestCase
  setup do
    @effort_rating = effort_ratings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:effort_ratings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create effort_rating" do
    assert_difference('EffortRating.count') do
      post :create, effort_rating: { opportunity_id: @effort_rating.opportunity_id, rating: @effort_rating.rating }
    end

    assert_redirected_to effort_rating_path(assigns(:effort_rating))
  end

  test "should show effort_rating" do
    get :show, id: @effort_rating
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @effort_rating
    assert_response :success
  end

  test "should update effort_rating" do
    patch :update, id: @effort_rating, effort_rating: { opportunity_id: @effort_rating.opportunity_id, rating: @effort_rating.rating }
    assert_redirected_to effort_rating_path(assigns(:effort_rating))
  end

  test "should destroy effort_rating" do
    assert_difference('EffortRating.count', -1) do
      delete :destroy, id: @effort_rating
    end

    assert_redirected_to effort_ratings_path
  end
end
