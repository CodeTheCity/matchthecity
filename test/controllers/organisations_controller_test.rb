require 'test_helper'

class OrganisationsControllerTest < ActionController::TestCase
  setup do
    @organisation = organisations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organisations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create organisation" do
    assert_difference('Organisation.count') do
      post :create, organisation: { address: @organisation.address, email: @organisation.email, latitude: @organisation.latitude, logo_url: @organisation.logo_url, longitude: @organisation.longitude, name: @organisation.name, postcode: @organisation.postcode, region_id: @organisation.region_id, telephone: @organisation.telephone, web: @organisation.web }
    end

    assert_redirected_to organisation_path(assigns(:organisation))
  end

  test "should show organisation" do
    get :show, id: @organisation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @organisation
    assert_response :success
  end

  test "should update organisation" do
    patch :update, id: @organisation, organisation: { address: @organisation.address, email: @organisation.email, latitude: @organisation.latitude, logo_url: @organisation.logo_url, longitude: @organisation.longitude, name: @organisation.name, postcode: @organisation.postcode, region_id: @organisation.region_id, telephone: @organisation.telephone, web: @organisation.web }
    assert_redirected_to organisation_path(assigns(:organisation))
  end

  test "should destroy organisation" do
    assert_difference('Organisation.count', -1) do
      delete :destroy, id: @organisation
    end

    assert_redirected_to organisations_path
  end
end
