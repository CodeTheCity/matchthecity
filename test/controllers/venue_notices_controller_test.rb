require 'test_helper'

class VenueNoticesControllerTest < ActionController::TestCase
  setup do
    @venue_notice = venue_notices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:venue_notices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create venue_notice" do
    assert_difference('VenueNotice.count') do
      post :create, venue_notice: { expires: @venue_notice.expires, message: @venue_notice.message, starts: @venue_notice.starts, venue_id: @venue_notice.venue_id }
    end

    assert_redirected_to venue_notice_path(assigns(:venue_notice))
  end

  test "should show venue_notice" do
    get :show, id: @venue_notice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @venue_notice
    assert_response :success
  end

  test "should update venue_notice" do
    patch :update, id: @venue_notice, venue_notice: { expires: @venue_notice.expires, message: @venue_notice.message, starts: @venue_notice.starts, venue_id: @venue_notice.venue_id }
    assert_redirected_to venue_notice_path(assigns(:venue_notice))
  end

  test "should destroy venue_notice" do
    assert_difference('VenueNotice.count', -1) do
      delete :destroy, id: @venue_notice
    end

    assert_redirected_to venue_notices_path
  end
end
