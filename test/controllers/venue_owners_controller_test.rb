require 'test_helper'

class VenueOwnersControllerTest < ActionController::TestCase
  setup do
    @venue_owner = venue_owners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:venue_owners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create venue_owner" do
    assert_difference('VenueOwner.count') do
      post :create, venue_owner: { address: @venue_owner.address, email: @venue_owner.email, latitude: @venue_owner.latitude, logo_url: @venue_owner.logo_url, longitude: @venue_owner.longitude, name: @venue_owner.name, postcode: @venue_owner.postcode, region_id: @venue_owner.region_id, telephone: @venue_owner.telephone, web: @venue_owner.web }
    end

    assert_redirected_to venue_owner_path(assigns(:venue_owner))
  end

  test "should show venue_owner" do
    get :show, id: @venue_owner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @venue_owner
    assert_response :success
  end

  test "should update venue_owner" do
    patch :update, id: @venue_owner, venue_owner: { address: @venue_owner.address, email: @venue_owner.email, latitude: @venue_owner.latitude, logo_url: @venue_owner.logo_url, longitude: @venue_owner.longitude, name: @venue_owner.name, postcode: @venue_owner.postcode, region_id: @venue_owner.region_id, telephone: @venue_owner.telephone, web: @venue_owner.web }
    assert_redirected_to venue_owner_path(assigns(:venue_owner))
  end

  test "should destroy venue_owner" do
    assert_difference('VenueOwner.count', -1) do
      delete :destroy, id: @venue_owner
    end

    assert_redirected_to venue_owners_path
  end
end
