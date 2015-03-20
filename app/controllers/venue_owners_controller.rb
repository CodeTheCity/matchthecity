class VenueOwnersController < ApplicationController
  include Swagger::Blocks

  swagger_api_root :venue_owners do
    key :swaggerVersion, '1.2'
    key :apiVersion, '1.0.0'
    key :basePath, Rails.application.routes.url_helpers.root_path
    api do
      key :path, '/venue_owners'
      operation do
        key :method, 'GET'
        key :summary, 'Returns all venue owners'
        key :notes, 'Returns all venue owners'
        key :type, :array
        key :nickname, :findVenueOwners
        parameter do
          key :paramType, :query
          key :name, :since
          key :description, "Returns venue owners updated since this date time. Since date format: yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
          key :type, :string
          key :required, false
        end
        items do
          key :'$ref', :VenueOwner
        end
      end
    end
    api do
      key :path, '/venue_owners/{venueOwnerSlug}'
      operation do
        key :method, 'GET'
        key :summary, 'Find venue owner by its slug'
        key :notes, 'Returns a venue owner based on slug'
        key :type, :VenueOwner
        key :nickname, :getVenueOwnerBySlug
        parameter do
          key :paramType, :path
          key :name, :venueOwnerSlug
          key :description, 'Slug of venue owner that needs to be fetched'
          key :required, true
          key :type, :string
        end
        response_message do
          key :code, 400
          key :message, 'Invalid slug supplied'
        end
        response_message do
          key :code, 404
          key :message, 'Venue owner not found'
        end
      end
    end
  end
  before_action :set_venue_owner, only: [:show, :edit, :update, :destroy]

  # GET /venue_owners
  # GET /venue_owners.json
  def index
    @venue_owners = VenueOwner.all
  end

  # GET /venue_owners/1
  # GET /venue_owners/1.json
  def show
  end

  # GET /venue_owners/new
  def new
    @venue_owner = VenueOwner.new
  end

  # GET /venue_owners/1/edit
  def edit
  end

  # POST /venue_owners
  # POST /venue_owners.json
  def create
    @venue_owner = VenueOwner.new(venue_owner_params)

    respond_to do |format|
      if @venue_owner.save
        format.html { redirect_to @venue_owner, notice: 'Venue owner was successfully created.' }
        format.json { render :show, status: :created, location: @venue_owner }
      else
        format.html { render :new }
        format.json { render json: @venue_owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /venue_owners/1
  # PATCH/PUT /venue_owners/1.json
  def update
    respond_to do |format|
      if @venue_owner.update(venue_owner_params)
        format.html { redirect_to @venue_owner, notice: 'Venue owner was successfully updated.' }
        format.json { render :show, status: :ok, location: @venue_owner }
      else
        format.html { render :edit }
        format.json { render json: @venue_owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venue_owners/1
  # DELETE /venue_owners/1.json
  def destroy
    @venue_owner.destroy
    respond_to do |format|
      format.html { redirect_to venue_owners_url, notice: 'Venue owner was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue_owner
      @venue_owner = VenueOwner.find_by_slug(params[:id])
      @venue_owner = VenueOwner.find_by_id(params[:id]) if @venue_owner.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_owner_params
      params.require(:venue_owner).permit(:name, :address, :postcode, :latitude, :longitude, :email, :telephone, :web, :region_id, :logo_url)
    end
end
