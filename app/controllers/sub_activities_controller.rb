class SubActivitiesController < ApplicationController
  before_action :set_sub_activity, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :create, :edit, :udpdate, :destroy]

  # GET /sub_activities
  # GET /sub_activities.json
  def index
    if @activity
      @sub_activities = @activity.sub_activities.order(:title).all
    else
      @sub_activities = SubActivity.order(:title).all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /sub_activities/1
  # GET /sub_activities/1.json
  def show
  end

  # GET /sub_activities/new
  def new
    @sub_activity = SubActivity.new
  end

  # GET /sub_activities/1/edit
  def edit
  end

  # POST /sub_activities
  # POST /sub_activities.json
  def create
    @sub_activity = SubActivity.new(sub_activity_params)

    respond_to do |format|
      if @sub_activity.save
        format.html { redirect_to @sub_activity, notice: 'Sub activity was successfully created.' }
        format.json { render :show, status: :created, location: @sub_activity }
      else
        format.html { render :new }
        format.json { render json: @sub_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_activities/1
  # PATCH/PUT /sub_activities/1.json
  def update
    respond_to do |format|
      if @sub_activity.update(sub_activity_params)
        format.html { redirect_to @sub_activity, notice: 'Sub activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub_activity }
      else
        format.html { render :edit }
        format.json { render json: @sub_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_activities/1
  # DELETE /sub_activities/1.json
  def destroy
    @sub_activity.destroy
    respond_to do |format|
      format.html { redirect_to sub_activities_url, notice: 'Sub activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_activity
      @sub_activity = SubActivity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_activity_params
      params.require(:sub_activity).permit(:activity_id, :title)
    end
end
