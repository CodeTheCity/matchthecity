class VenueNoticesController < ApplicationController
  before_action :set_venue_notice, only: [:show, :edit, :update, :destroy]

  # GET /venue_notices
  # GET /venue_notices.json
  def index
    @venue_notices = VenueNotice.all
  end

  # GET /venue_notices/1
  # GET /venue_notices/1.json
  def show
  end

  # GET /venue_notices/new
  def new
    @venue_notice = VenueNotice.new
  end

  # GET /venue_notices/1/edit
  def edit
  end

  # POST /venue_notices
  # POST /venue_notices.json
  def create
    @venue_notice = VenueNotice.new(venue_notice_params)

    respond_to do |format|
      if @venue_notice.save
        format.html { redirect_to @venue_notice, notice: 'Venue notice was successfully created.' }
        format.json { render :show, status: :created, location: @venue_notice }
      else
        format.html { render :new }
        format.json { render json: @venue_notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /venue_notices/1
  # PATCH/PUT /venue_notices/1.json
  def update
    respond_to do |format|
      if @venue_notice.update(venue_notice_params)
        format.html { redirect_to @venue_notice, notice: 'Venue notice was successfully updated.' }
        format.json { render :show, status: :ok, location: @venue_notice }
      else
        format.html { render :edit }
        format.json { render json: @venue_notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venue_notices/1
  # DELETE /venue_notices/1.json
  def destroy
    @venue_notice.destroy
    respond_to do |format|
      format.html { redirect_to venue_notices_url, notice: 'Venue notice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue_notice
      @venue_notice = VenueNotice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def venue_notice_params
      params.require(:venue_notice).permit(:venue_id, :starts, :expires, :message)
    end
end
