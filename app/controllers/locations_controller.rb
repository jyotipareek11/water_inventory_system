class LocationsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.active.to_a
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @modifier = User.find_by_id(@location.modified_by) if @location.modified_by 
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)
    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render action: 'show', status: :created, location: @location }
      else
        format.html { render action: 'new' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    @location.modified_by = current_user.id
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    respond_to do |format|
      if @location.make_inactive
        format.html { redirect_to locations_url, notice: 'Location deleted successfully.'  }
        format.json { head :no_content }
      else
        format.html { render action: 'show' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end  
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name, :address1, :address2, :city, :state, :country, :added_by, :added_date, :modified_by, :modified_date)
    end
end
