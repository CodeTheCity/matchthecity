class EffortRatingsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  before_action :set_effort_rating, only: [:show, :edit, :update, :destroy]

  before_filter :find_opportunity,

  # GET /effort_ratings
  # GET /effort_ratings.json
  def index
    @effort_ratings = EffortRating.all.page(params[:page]).per(50)
  end

  # GET /effort_ratings/1
  # GET /effort_ratings/1.json
  def show
  end

  # GET /effort_ratings/new
  def new
    @effort_rating = EffortRating.new
  end

  # GET /effort_ratings/1/edit
  def edit
  end

  # POST /effort_ratings
  # POST /effort_ratings.json
  def create

    puts params
    puts @opportunity
    @effort_rating = @opportunity.effort_ratings.new(effort_rating_params)

    respond_to do |format|
      if @effort_rating.save
        @opportunity.effort_rating = @opportunity.effort_ratings.average(:rating)
        @opportunity.save
        format.html { redirect_to @opportunity, notice: 'Effort rating was successfully created.' }
        format.json { render :show, status: :created, location: @effort_rating }
      else
        format.html { render :new }
        format.json { render json: @opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /effort_ratings/1
  # PATCH/PUT /effort_ratings/1.json
  def update
    respond_to do |format|
      if @effort_rating.update(effort_rating_params)
        format.html { redirect_to @effort_rating, notice: 'Effort rating was successfully updated.' }
        format.json { render :show, status: :ok, location: @effort_rating }
      else
        format.html { render :edit }
        format.json { render json: @effort_rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /effort_ratings
  def delete_all
    code = params[:code]
    if code == 'turnip'
      EffortRating.delete_all
    end

    respond_to do |format|
      format.html { redirect_to effort_ratings_url, notice: 'Effort ratings where destroyed.' }
    end
  end


  # DELETE /effort_ratings/1
  # DELETE /effort_ratings/1.json
  def destroy
    @effort_rating.destroy
    respond_to do |format|
      format.html { redirect_to effort_ratings_url, notice: 'Effort rating was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_effort_rating
      @effort_rating = EffortRating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def effort_rating_params
      params.require(:effort_rating).permit(:rating, :opportunity_id)
    end


  def find_opportunity
    @opportunity = Opportunity.find_by_id(params[:opportunity_id])
  end
end
