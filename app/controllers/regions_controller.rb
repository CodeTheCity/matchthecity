class RegionsController < ApplicationController
  include Swagger::Blocks

  swagger_path '/regions' do
    operation :get do
      key :description, 'Returns all regions from the system'
      key :operationId, 'findRegions'
      key :produces, [
        'application/json',
        'text/html'
      ]
      key :tags, [
        'region'
      ]
      response 200 do
        key :description, 'region response'
        schema do
          key :type, :array
          items do
            key :'$ref', :Region
          end
        end
      end
    end
  end
  swagger_path '/regions/{id}' do
    operation :get do
      key :description, 'Returns a single region'
      key :operationId, 'findRegionById'
      key :tags, [
        'region'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, "ID of region to fetch"
        key :required, true
        key :type, :integer
        key :format, :int64
      end
      response 200 do
        key :description, 'region response'
        schema do
          key :'$ref', :Region
        end
      end
      response 400 do
        key :description, 'Invalid ID supplied'
      end
      response 404 do
        key :description, 'Region not found'
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
