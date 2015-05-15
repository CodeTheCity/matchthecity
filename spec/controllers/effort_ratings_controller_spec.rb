require 'rails_helper'

describe EffortRatingsController do
  describe 'GET #index' do
    it "assigns @effort_ratings" do
      effort_rating = create(:effort_rating)
      get :index
      expect(assigns(:effort_ratings)).to eq([effort_rating])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe 'GET #show' do
    it "assigns the requested effort_rating to @effort_rating" do
      effort_rating = create(:effort_rating)
      get :show, id: effort_rating
      expect(assigns(:effort_rating)).to eq(effort_rating)
    end

    it "renders the show template" do
      get :show, id: create(:effort_rating)
      expect(response).to render_template("show")
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it "creates a new effort_rating" do
        opportunity = create(:opportunity)
        puts opportunity.id
        expect {
          post :create, effort_rating: FactoryGirl.attributes_for(:effort_rating, ).merge({:opportunity_id => opportunity})
        }.to change(EffortRating, :count).by(1)
      end
    end

    context "with invalid attributes" do
    end
  end
end