class OpportunitiesController < ApplicationController
  before_action :set_opportunity, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :create, :edit, :udpdate, :destroy]
  before_filter :find_venue, :find_region


  # GET /opportunities
  # GET /opportunities.json
  def index
    sub_activity = SubActivity.find_by_id(params[:sub_activity])
    if params[:effort_rating]
      effort_rating = params[:effort_rating]
    end

    if params[:since]
      since_datetime = Time.parse(params[:since])
    else
      since_datetime = Time.parse("01-01-1970'T'00:00:00.0Z")
    end

  respond_to do |format|
    format.html {
      if sub_activity
        @opportunities = Opportunity.for_venue(@venue).for_region(@region).with_effort_rating(effort_rating).where(:sub_activity => sub_activity).where(["updated_at >= ?",  since_datetime])
      else
        @opportunities = Opportunity.for_venue(@venue).for_region(@region).with_effort_rating(effort_rating).where(["opportunities.updated_at >= ?",  since_datetime]).page(params[:page]).per(50)
      end
    }
    format.json {
      if sub_activity
        @opportunities = Opportunity.for_venue(@venue).for_region(@region).with_effort_rating(effort_rating).where(:sub_activity => sub_activity).where(["updated_at >= ?",  since_datetime])
      else
        @opportunities = Opportunity.for_venue(@venue).for_region(@region).with_effort_rating(effort_rating).where(["opportunities.updated_at >= ?",  since_datetime])
      end
    }
  end

  end

  # GET /opportunities/1
  # GET /opportunities/1.json
  def show
  end

  # GET /opportunities/new
  def new
    @opportunity = Opportunity.new
  end

  # GET /opportunities/1/edit
  def edit
  end

  # POST /opportunities
  # POST /opportunities.json
  def create
    @opportunity = Opportunity.new(opportunity_params)

    respond_to do |format|
      if @opportunity.save
        format.html { redirect_to @opportunity, notice: 'Opportunity was successfully created.' }
        format.json { render :show, status: :created, location: @opportunity }
      else
        format.html { render :new }
        format.json { render json: @opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opportunities/1
  # PATCH/PUT /opportunities/1.json
  def update
    respond_to do |format|
      if @opportunity.update(opportunity_params)
        format.html { redirect_to @opportunity, notice: 'Opportunity was successfully updated.' }
        format.json { render :show, status: :ok, location: @opportunity }
      else
        format.html { render :edit }
        format.json { render json: @opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opportunities/1
  # DELETE /opportunities/1.json
  def destroy
    @opportunity.destroy
    respond_to do |format|
      format.html { redirect_to opportunities_url, notice: 'Opportunity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opportunity
      @opportunity = Opportunity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opportunity_params
      params.require(:opportunity).permit(:name, :category, :description, :activity_id, :sub_activity_id, :venue_id, :room, :start_time, :end_time, :day_of_week,:skill_ids => [])
    end

    private
    def find_venue
      @venue = Venue.find_by_id(params[:venue_id])
    end

    def find_region
      @region = Region.find_by_id(params[:region_id])
    end
end
