require 'rails_helper'

describe RegionsController do
  describe 'GET #index' do
    it "assigns @regions" do
      region = create(:region)
      get :index
      expect(assigns(:regions)).to eq([region])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe 'GET #show' do
    it "assigns the requested region to @region" do
      region = create(:region)
      get :show, id: region
      expect(assigns(:region)).to eq(region)
    end

    it "renders the show template" do
      get :show, id: create(:region)
      expect(response).to render_template("show")
    end
  end
end