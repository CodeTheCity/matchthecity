require 'rails_helper'

describe EffortRatingsController do
  let(:opportunity) { FactoryGirl.create(:opportunity) }

  describe 'GET #index' do
    it "assigns @effort_ratings" do
      effort_rating = create(:effort_rating)
      get :index, opportunity_id: opportunity.id
      expect(assigns(:effort_ratings)).to eq([effort_rating])
    end

    it "renders the index template" do
      get :index, opportunity_id: opportunity.id
      expect(response).to render_template("index")
    end
  end

  describe 'GET #show' do
    it "assigns the requested effort_rating to @effort_rating" do
      effort_rating = create(:effort_rating)
      get :show, id: effort_rating, opportunity_id: opportunity.id
      expect(assigns(:effort_rating)).to eq(effort_rating)
    end

    it "renders the show template" do
      get :show, id: create(:effort_rating), opportunity_id: opportunity.id
      expect(response).to render_template("show")
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it "creates a new effort_rating" do
        
        expect {
          post :create, opportunity_id: opportunity.id, effort_rating: FactoryGirl.attributes_for(:effort_rating)
        }.to change(EffortRating, :count).by(1)
      end
    end

    context "with invalid attributes" do
    end
  end
end