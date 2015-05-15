require 'rails_helper'

describe OpportunitiesController do
  describe 'GET #index' do
    it "assigns @opportunities" do
      opportunity = create(:opportunity)
      get :index
      expect(assigns(:opportunities)).to eq([opportunity])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe 'GET #show' do
    it "assigns the requested opportunity to @opportunity" do
      opportunity = create(:opportunity)
      get :show, id: opportunity
      expect(assigns(:opportunity)).to eq(opportunity)
    end

    it "renders the show template" do
      get :show, id: create(:opportunity)
      expect(response).to render_template("show")
    end
  end
end