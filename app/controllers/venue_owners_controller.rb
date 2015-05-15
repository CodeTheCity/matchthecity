class VenueOwnersController < ApplicationController
  include Swagger::Blocks

  swagger_path '/venue_owners' do
    operation :get do
      key :description, 'Returns all venue owners'
      key :operationId, 'findVenueOwners'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'venue owner'
      ]
      parameter do
          key :name, :since
          key :in, :query
          key :description, "Returns venue owners updated since this date time. Since date format: yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
          key :type, :string
          key :required, false
        end
      response 200 do
        key :description, 'venue owner response'
        schema do
          key :type, :array
          items do
            key :'$ref', :VenueOwner
          end
        end
      end
    end
  end
  swagger_path '/venue_owners/{venueOwnerSlug}' do
    operation :get do
      key :description, 'Returns a single venue owner'
      key :operationId, 'findVenueOwnerBySlug'
      key :tags, [
        'venue owner'
      ]
      parameter do
        key :in, :path
        key :name, :venueOwnerSlug
        key :description, 'Slug of venue owner that needs to be fetched'
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'venue owner response'
        schema do
          key :'$ref', :VenueOwner
        end
      end
      response 400 do
        key :description, 'Invalid slug supplied'
      end
      response 404 do
        key :description, 'Venue owner not found'
      end
    end
  end
  before_action :set_venue_owner, only: [:show, :edit, :update, :destroy]

  # GET /venue_owners
  # GET /venue_owners.json
  def index
    @venue_owners = VenueOwner.all.order(:name)
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
