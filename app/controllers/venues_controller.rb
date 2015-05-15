class VenuesController < ApplicationController
  include Swagger::Blocks

  swagger_path '/venues' do
    operation :get do
      key :description, 'Returns all venue'
      key :operationId, 'findVenues'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'venue'
      ]
      parameter do
          key :name, :since
          key :in, :query
          key :description, "Returns venues updated since this date time. Since date format: yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
          key :type, :string
          key :required, false
        end
      response 200 do
        key :description, 'venue response'
        schema do
          key :type, :array
          items do
            key :'$ref', :Venue
          end
        end
      end
    end
  end

  swagger_path '/regions/{regionId}/venues' do
    operation :get do
      key :description, 'Returns all venues for a region'
      key :operationId, 'findVenuesForRegion'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'venue'
      ]
      parameter do
          key :name, :regionId
          key :in, :path
          key :description, 'Id of the region you wish to return venues for'
          key :required, true
          key :type, :integer
        end
      parameter do
          key :name, :since
          key :in, :query
          key :description, "Returns venues updated since this date time. Since date format: yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
          key :type, :string
          key :required, false
        end
      response 200 do
        key :description, 'venue response'
        schema do
          key :type, :array
          items do
            key :'$ref', :Venue
          end
        end
      end
    end
  end
  swagger_path '/venues/{venueSlug}' do
    operation :get do
      key :description, 'Returns a single venue'
      key :operationId, 'findVenueBySlug'
      key :tags, [
        'venue'
      ]
      parameter do
        key :in, :path
        key :name, :venueSlug
        key :description, 'Slug of venue that needs to be fetched'
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'venue response'
        schema do
          key :'$ref', :Venue
        end
      end
      response 400 do
        key :description, 'Invalid slug supplied'
      end
      response 404 do
        key :description, 'Venue not found'
      end
    end
  end

  before_action :set_venue, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :create, :edit, :udpdate, :destroy]
  before_filter :find_region, :find_venue_owner

  # GET /venues
  # GET /venues.json
  def index
    if params[:since]
      since_datetime = Time.parse(params[:since])
      puts since_datetime
      @venues = Venue.for_venue_owner(@venue_owner).for_region(params[:region_id]).order(:name).where(["updated_at >= ?",  since_datetime])
    else
      @venues = Venue.for_venue_owner(@venue_owner).for_region(params[:region_id]).order(:name)
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
      @venue = Venue.find_by_slug(params[:id])
      @venue = Venue.find_by_id(params[:id]) if @venue.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_params
      params.require(:venue).permit(:name, :address, :postcode, :latitude, :longitude, :web, :telephone, :email)
    end

    def find_region
      @region = Region.find_by_id(params[:region_id])
    end

    def find_venue_owner
      @venue_owner = VenueOwner.find_by_slug(params[:venue_owner_id])
      @venue_owner = VenueOwner.find_by_id(params[:venue_owner_id]) if @venue_owner.nil?
    end
end
