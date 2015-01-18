class VenueOwnersController < ApplicationController
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
      @venue_owner = VenueOwner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_owner_params
      params.require(:venue_owner).permit(:name, :address, :postcode, :latitude, :longitude, :email, :telephone, :web, :region_id, :logo_url)
    end
end
