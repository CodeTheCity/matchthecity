class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


# GET /users
  # GET /users.json
  def index

    @organisation = Organisation.find(params[:organisation_id]) if params[:organisation_id]

    if params[:search]
      search = params[:search]
      @users = User.order(:name).where(["lower(name) LIKE ?", "%#{search.downcase}%"]).all
    else
      @users = User.order(:name).all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /organisations/1/invite
  def invite
    @user = User.find(params[:user_id])
    @organisation = Organisation.find(params[:organisation_id]) if params[:organisation_id]

    @organisation.users << @user unless @organisation.users.include?(@user)


    respond_to do |format|
        format.html { redirect_to @organisation, notice: "#{@user.name} has been added to #{@organisation.name}" }
    end
  end

  # GET /organisations/1/uninvite
  def uninvite
    @user = User.find(params[:user_id])
    @organisation = Organisation.find(params[:organisation_id]) if params[:organisation_id]

    @organisation.users.delete @user


    respond_to do |format|
        format.html { redirect_to @organisation, notice: "#{@user.name} has been removed from #{@organisation.name}" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
end