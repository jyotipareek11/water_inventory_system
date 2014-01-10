class DistributorsController < ApplicationController
	before_filter :authenticate_user!
  	before_action :set_location, only: [:index,:show, :edit, :update, :destroy,:new,:create]
  	before_action :set_distributor, only: [:show, :edit, :update, :destroy]
	
	def select
		@locations = Location.active.to_a
	end

	def index
		@distributors = @location.distributors.active
		respond_to do |format|
			format.html
			format.js
		end	
	end

  def show

  end  

  def new
      @distributor = User.new
  end
  
  def create
    @user = User.create_new_distributor(params[:user][:email],params[:user][:password],params[:user][:first_name],params[:user][:last_name],@location.id)
     respond_to do |format|
      if @user.save
        format.html { redirect_to location_distributors_path(@location)  , notice: 'Distributor was successfully created.' }
      else
        str= ""
        @user.errors.full_messages.each do |m|
          str+= "<div>"+m+"</div>"
        end  
        format.html { redirect_to new_location_distributor_path(@location), notice: str}
      end
    end
  end  

	def destroy
    	respond_to do |format|
        if @distributor.make_inactive
      	  format.html { redirect_to location_distributors_url(@location), notice: 'Distributor deleted successfully.' }
      	  format.json { head :no_content }
        else
          format.html { redirect_to location_distributors_url(@location) }
          format.json { head :no_content }
        end  
    	end
  	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:location_id])
    end

    def set_distributor
      @distributor = User.find(params[:id]) 
    end

end
