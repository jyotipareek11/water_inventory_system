class UsersController < ApplicationController
	 before_filter :authenticate_user!

	def distributors
		@users = User.distributors
	end	

	def clients
		@users = User.clients
	end	

	def show
		@user = User.find(params[:id])
	end
end
