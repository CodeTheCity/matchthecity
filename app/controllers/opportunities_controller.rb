class OpportunitiesController < ApplicationController
  include Swagger::Blocks

  swagger_api_root :opportunities do
    key :swaggerVersion, '1.2'
    key :apiVersion, '1.0.0'
    key :basePath, Rails.application.routes.url_helpers.root_path
    api do
      key :path, '/opportunities'
      operation do
        key :method, 'GET'
        key :summary, 'Returns all opportunities'
        key :notes, 'Returns all opportunities'
        key :type, :array
        key :nickname, :findOpportunities
        parameter do
          key :paramType, :query
          key :name, :since
          key :description, "Returns opportunities updated since this date time. Since date format: yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
          key :type, :string
          key :required, false
        end
        parameter do
          key :paramType, :query
          key :name, :effort_rating
          key :description, "Returns opportunities with the requested effort rating"
          key :type, :integer
          key :required, false
        end
        items do
          key :'$ref', :Opportunity
        end
      end
    end
    api do
      key :path, '/regions/{regionId}/opportunities'
      operation do
        key :method, 'GET'
        key :summary, 'Returns all opportunities for the given region'
        key :notes, 'Returns all opportunities for the given region'
        key :type, :array
        key :nickname, :findOpportunitiesForRegion
        parameter do
          key :paramType, :path
          key :name, :regionId
          key :description, 'Id of the region that opportunities are to be fetched for'
          key :required, true
          key :type, :string
        end
        parameter do
          key :paramType, :query
          key :name, :since
          key :description, "Returns opportunities updated since this date time. Since date format: yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
          key :type, :string
          key :required, false
        end
        parameter do
          key :paramType, :query
          key :name, :effort_rating
          key :description, "Returns opportunities with the requested effort rating"
          key :type, :integer
          key :required, false
        end
        items do
          key :'$ref', :Opportunity
        end
      end
    end
    api do
      key :path, '/venues/{venueId}/opportunities'
      operation do
        key :method, 'GET'
        key :summary, 'Returns all opportunities for the given venue'
        key :notes, 'Returns all opportunities for the given venue'
        key :type, :array
        key :nickname, :findOpportunitiesForVenue
        parameter do
          key :paramType, :path
          key :name, :venueId
          key :description, 'Id of the venue that opportunities are to be fetched for'
          key :required, true
          key :type, :string
        end
        parameter do
          key :paramType, :query
          key :name, :since
          key :description, "Returns opportunities updated since this date time. Since date format: yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
          key :type, :string
          key :required, false
        end
        parameter do
          key :paramType, :query
          key :name, :effort_rating
          key :description, "Returns opportunities with the requested effort rating"
          key :type, :integer
          key :required, false
        end
        items do
          key :'$ref', :Opportunity
        end
      end
    end
    api do
      key :path, '/opportunities/{opportunityId}'
      operation do
        key :method, 'GET'
        key :summary, 'Find opportunity by its Id'
        key :notes, 'Returns a opportunity based on Id'
        key :type, :Opportunity
        key :nickname, :getOpportunityById
        parameter do
          key :paramType, :path
          key :name, :opportunityId
          key :description, 'Id of the opportunity that needs to be fetched'
          key :required, true
          key :type, :string
        end
        response_message do
          key :code, 400
          key :message, 'Invalid Id supplied'
        end
        response_message do
          key :code, 404
          key :message, 'Opportunity not found'
        end
      end
    end
    api do
      key :path, '/opportunities/{opportunityId}/effort_ratings'
      operation do
        key :method, 'POST'
        key :summary, 'Creates an Effort Rating for the opportunity'
        key :notes, 'Returns the new Effort Rating'
        key :type, :integer
        key :nickname, :createEffortForOpportunity
        parameter do
          key :paramType, :path
          key :name, :opportunityId
          key :description, 'Id of the opportunity that is being rated'
          key :required, true
          key :type, :string
        end
        parameter do
          key :paramType, :form
          key :name, :rating
          key :description, 'Effort rating 1 - 5'
          key :required, true
          key :type, :integer
        end
        response_message do
          key :code, 400
          key :message, 'Invalid Id supplied'
        end
        response_message do
          key :code, 404
          key :message, 'Opportunity not found'
        end
      end
    end
  end

  before_action :set_opportunity, only: [:show, :edit, :update, :destroy]
  before_action :set_organisation, only: [:new, :create]
  before_action :authenticate_user!, only: [:new, :create, :edit, :udpdate, :destroy]
  before_filter :find_venue, :find_region
  before_filter :has_permission, only: [:new, :create, :edit, :update, :destroy]


  def tag_cloud
    @tags = Opportunity.tag_counts_on(:tags)
  end


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
        @opportunities = Opportunity.for_venue(@venue).for_region(@region).with_effort_rating(effort_rating).where(:sub_activity => sub_activity).where(["updated_at >= ?",  since_datetime]).page(params[:page]).per(50)
      else
        @opportunities = Opportunity.for_venue(@venue).for_region(@region).with_effort_rating(effort_rating).order(:name).where(["opportunities.updated_at >= ?",  since_datetime]).page(params[:page]).per(50)
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
    @activities = Activity.all
    @sub_activities = []
    @opportunity.category = "Event"

  end

  # GET /opportunities/1/edit
  def edit
    @activities = Activity.all
    @sub_activities = @opportunity.activity.sub_activities.order(:title)
  end

  # POST /opportunities
  # POST /opportunities.json
  def create

    @opportunity = Opportunity.new(opportunity_params)
    @opportunity.organisation = @organisation

    unless opportunity_params[:new_activity].blank?
      activity = Activity.find_by_title(opportunity_params[:new_activity])
      if activity.nil?
        activity = Activity.new(:title => opportunity_params[:new_activity])
        activity.save
      end
      @opportunity.activity = activity
    end

    unless opportunity_params[:new_sub_activity].blank?
      sub_activity = @opportunity.activity.sub_activities.find_by_title(opportunity_params[:new_sub_activity])
      if sub_activity.nil?
        sub_activity = @opportunity.activity.sub_activities.new(:title => opportunity_params[:new_sub_activity])
        sub_activity.save
      end
      @opportunity.sub_activity = sub_activity
    end

    respond_to do |format|
      if @opportunity.save
        format.html { redirect_to @opportunity, notice: 'Opportunity was successfully created.' }
        format.json { render :show, status: :created, location: @opportunity }
      else
        @activities = Activity.all
        @sub_activities = []
        format.html { render :new }
        format.json { render json: @opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opportunities/1
  # PATCH/PUT /opportunities/1.json
  def update

    params = opportunity_params

    unless params[:new_activity].blank?
      activity = Activity.find_by_title(params[:new_activity])
      if activity.nil?
        activity = Activity.new(:title => params[:new_activity])
        activity.save
      end
      params[:activity_id] = activity.id
    end

    unless params[:new_sub_activity].blank?
      sub_activity = @opportunity.activity.sub_activities.find_by_title(params[:new_sub_activity])
      if sub_activity.nil?
        sub_activity = @opportunity.activity.sub_activities.new(:title => params[:new_sub_activity])
        sub_activity.save
      end
      params[:sub_activity_id] = sub_activity.id
    end
    respond_to do |format|
      if @opportunity.update(params)
        format.html { redirect_to @opportunity, notice: 'Opportunity was successfully updated.' }
        format.json { render :show, status: :ok, location: @opportunity }
      else
        @activities = Activity.all
        @sub_activities = @opportunity.activity.sub_activities.order(:title)
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

  def update_sub_activities
    @opportunity = Opportunity.new
    @activity = Activity.find(params[:activity_id])
    @sub_activities = @activity.sub_activities.order(:title).all

    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opportunity
      @opportunity = Opportunity.find(params[:id])
    end

    def set_organisation
      @organisation = Organisation.find(params[:organisation_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opportunity_params
      params.require(:opportunity).permit(:name, :category, :description, :activity_id, :sub_activity_id, :venue_id, :room, :start_time, :end_time, :day_of_week, :new_activity, :new_sub_activity,:skill_ids => [])
    end

    private
    def find_venue
      @venue = Venue.find_by_slug(params[:venue_id])
      @venue = Venue.find_by_id(params[:venue_id]) if @venue.nil?
    end

    def find_region
      @region = Region.find_by_id(params[:region_id])
    end

    def has_permission
      @organisation = @opportunity.organisation if @organisation.nil?
      if @organisation
        unless @organisation.users.include?(current_user)
          redirect_to(welcome_index_path, :alert => t(:restricted_page))
        end
      else
        redirect_to(welcome_index_path, :alert => t(:restricted_page))
      end
    end
end
