class RegionsController < ApplicationController
  include Swagger::Blocks

  

  swagger_api_root :regions do
    key :swaggerVersion, '1.2'
    key :apiVersion, '1.0.0'
    key :basePath, Rails.application.routes.url_helpers.regions_path
    api do
      key :path, '/'
      operation do
        key :method, 'GET'
        key :summary, 'Returns all regions'
        key :notes, 'Returns all regions'
        key :type, :array
        key :nickname, :findRegions
        items do
          key :'$ref', :Region
        end
      end
    end
    api do
      key :path, '/{regionId}'
      operation do
        key :method, 'GET'
        key :summary, 'Find region by ID'
        key :notes, 'Returns a region based on ID'
        key :type, :Region
        key :nickname, :getRegionById
        parameter do
          key :paramType, :path
          key :name, :regionId
          key :description, 'ID of region that needs to be fetched'
          key :required, true
          key :type, :integer
        end
        response_message do
          key :code, 400
          key :message, 'Invalid ID supplied'
        end
        response_message do
          key :code, 404
          key :message, 'Region not found'
        end
      end
    end
  end

  before_action :set_region, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:new, :edit, :update, :destroy]

  # GET /regions
  # GET /regions.json
  def index
    @regions = Region.all
  end

  # GET /regions/1
  # GET /regions/1.json
  def show
  end

  # GET /regions/new
  def new
    @region = Region.new
  end

  # GET /regions/1/edit
  def edit
  end

  # POST /regions
  # POST /regions.json
  def create
    @region = Region.new(region_params)

    respond_to do |format|
      if @region.save
        format.html { redirect_to @region, notice: 'Region was successfully created.' }
        format.json { render :show, status: :created, location: @region }
      else
        format.html { render :new }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /regions/1
  # PATCH/PUT /regions/1.json
  def update
    respond_to do |format|
      if @region.update(region_params)
        format.html { redirect_to @region, notice: 'Region was successfully updated.' }
        format.json { render :show, status: :ok, location: @region }
      else
        format.html { render :edit }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regions/1
  # DELETE /regions/1.json
  def destroy
    @region.destroy
    respond_to do |format|
      format.html { redirect_to regions_url, notice: 'Region was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_region
      @region = Region.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def region_params
      params.require(:region).permit(:name)
    end
end
