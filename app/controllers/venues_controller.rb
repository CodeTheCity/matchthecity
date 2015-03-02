class VenuesController < ApplicationController
  include Swagger::Blocks

  swagger_api_root :venues do
    key :swaggerVersion, '1.2'
    key :apiVersion, '1.0.0'
    key :basePath, Rails.application.routes.url_helpers.root_path
    api do
      key :path, '/venues'
      operation do
        key :method, 'GET'
        key :summary, 'Returns all venues'
        key :notes, 'Returns all venues'
        key :type, :array
        key :nickname, :findVenues
        parameter do
          key :paramType, :query
          key :name, :since
          key :description, "Returns venues updated since this date time. Since date format: yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
          key :type, :string
          key :required, false
        end
        items do
          key :'$ref', :Venue
        end
      end
    end
    api do
      key :path, '/regions/{regionId}/venues'
      operation do
        key :method, 'GET'
        key :summary, 'Returns all venues for region regionId'
        key :notes, 'Returns all venues for a region'
        key :type, :array
        key :nickname, :findVenues
        parameter do
          key :paramType, :path
          key :name, :regionId
          key :description, 'Id of the region you wish to return venues for'
          key :required, true
          key :type, :integer
        end
        items do
          key :'$ref', :Venue
        end
      end
    end
    api do
      key :path, '/venues/{venueSlug}'
      operation do
        key :method, 'GET'
        key :summary, 'Find venue by its slug'
        key :notes, 'Returns a venue based on slug'
        key :type, :Venue
        key :nickname, :getVenueBySlug
        parameter do
          key :paramType, :path
          key :name, :venueSlug
          key :description, 'Slug of venue that needs to be fetched'
          key :required, true
          key :type, :string
        end
        response_message do
          key :code, 400
          key :message, 'Invalid slug supplied'
        end
        response_message do
          key :code, 404
          key :message, 'Venue not found'
        end
      end
    end
  end
  before_action :set_venue, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :create, :edit, :udpdate, :destroy]
  before_filter :find_region


  # GET /venues
  # GET /venues.json
  def index
    if params[:since]
      since_datetime = Time.parse(params[:since])
      puts since_datetime
      @venues = Venue.for_region(params[:region_id]).order(:name).where(["updated_at >= ?",  since_datetime])
    else
      @venues = Venue.for_region(params[:region_id]).order(:name)
    end
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
  end

  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
  end

  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.new(venue_params)

    respond_to do |format|
      if @venue.save
        format.html { redirect_to @venue, notice: 'Venue was successfully created.' }
        format.json { render :show, status: :created, location: @venue }
      else
        format.html { render :new }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
    respond_to do |format|
      if @venue.update(venue_params)
        format.html { redirect_to @venue, notice: 'Venue was successfully updated.' }
        format.json { render :show, status: :ok, location: @venue }
      else
        format.html { render :edit }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @venue.destroy
    respond_to do |format|
      format.html { redirect_to venues_url, notice: 'Venue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.find_by_slug!(params[:id])
      @venue = Venue.find_by_id(params[:id]) if @venue.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_params
      params.require(:venue).permit(:name, :address, :postcode, :latitude, :longitude, :web, :telephone, :email)
    end

    def find_region
      @region = Region.find_by_id(params[:region_id])
    end
end
